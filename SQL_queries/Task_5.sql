SELECT date,
       orders,
       first_orders,
       new_users_orders,
       round(first_orders::decimal / orders * 100, 2) as first_orders_share,
       round(new_users_orders::decimal / orders * 100, 2) as new_users_orders_share
FROM   (SELECT date,
               count(user_id) as first_orders
        FROM   (SELECT DISTINCT user_id,
                                min(time::date) OVER(PARTITION BY user_id) as date
                FROM   user_actions
                WHERE  order_id not in (SELECT order_id
                                        FROM   user_actions
                                        WHERE  action = 'cancel_order')
                ORDER BY 1) t1
        GROUP BY date
        ORDER BY date) q1 join (SELECT date(time) as date,
                               count(order_id) as orders
                        FROM   user_actions
                        WHERE  order_id not in (SELECT order_id
                                                FROM   user_actions
                                                WHERE  action = 'cancel_order')
                        GROUP BY date
                        ORDER BY date) q2 using (date) join (SELECT date(first_order_time) as date,
                                            count(order_id) as new_users_orders
                                     FROM   (SELECT user_id,
                                                    min(time) as first_order_time
                                             FROM   user_actions
                                             GROUP BY user_id) t2 join user_actions ua
                                             ON t2.user_id = ua.user_id and
                                                date(t2.first_order_time) = date(ua.time)
                                     WHERE  order_id not in (SELECT order_id
                                                             FROM   user_actions
                                                             WHERE  action = 'cancel_order')
                                     GROUP BY date
                                     ORDER BY date) q3 using (date);