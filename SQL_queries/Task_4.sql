SELECT date,
       round(single_order_users::decimal / paying_users * 100,
             2) as single_order_users_share,
       100 - round(single_order_users::decimal / paying_users * 100,
                   2) as several_orders_users_share
FROM   (SELECT date,
               count(user_id) as single_order_users
        FROM   (SELECT date_trunc('day', time)::date as date,
                       user_id,
                       count(order_id) OVER(PARTITION BY time::date,
                                                         user_id) as count_orders_in_day
                FROM   user_actions
                WHERE  action = 'create_order'
                   and order_id not in (SELECT order_id
                                     FROM   user_actions
                                     WHERE  action = 'cancel_order')) q1
        WHERE  count_orders_in_day = 1
        GROUP BY date)q2 join (SELECT date_trunc('day', time)::date as date,
                              count(distinct user_id) filter(WHERE action = 'create_order' and order_id not in (SELECT order_id
                                                                                                         FROM   user_actions
                                                                                                         WHERE  action = 'cancel_order')) as paying_users
                       FROM   user_actions
                       GROUP BY date)q4 using (date)
ORDER BY date;