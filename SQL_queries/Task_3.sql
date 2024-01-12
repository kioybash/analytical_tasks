SELECT date,
       paying_users,
       active_couriers,
       round(paying_users::decimal / total_users * 100, 2) as paying_users_share,
       round(active_couriers::decimal / total_couriers * 100, 2) as active_couriers_share
FROM   (SELECT date_trunc('day', time)::date as date,
               count(distinct user_id) filter(WHERE action = 'create_order' and order_id not in (SELECT order_id
                                                                                          FROM   user_actions
                                                                                          WHERE  action = 'cancel_order')) as paying_users, count(distinct user_id) as new_users
        FROM   user_actions
        GROUP BY date
        ORDER BY date) t1 full join (SELECT date_trunc('day', time)::date as date,
                                    count(distinct courier_id) filter(WHERE action in ('accept_order', 'deliver_order') and order_id not in (SELECT order_id
                                                                                                                                      FROM   user_actions
                                                                                                                                      WHERE  action = 'cancel_order')) as active_couriers, count(distinct courier_id) as new_couriers
                             FROM   courier_actions
                             GROUP BY date
                             ORDER BY date) t2 using (date) full join (SELECT date,
                                                 count(user_id) as new_users,
                                                 sum(count(user_id)) OVER(ORDER BY date)::integer as total_users
                                          FROM   (SELECT DISTINCT user_id,
                                                                  min(time::date) OVER(PARTITION BY user_id) as date
                                                  FROM   user_actions
                                                  ORDER BY 1) t3
                                          GROUP BY date
                                          ORDER BY date) t4 using (date) full join (SELECT date,
                                                 count(courier_id) as new_couriers,
                                                 sum(count(courier_id)) OVER(ORDER BY date)::integer as total_couriers
                                          FROM   (SELECT DISTINCT courier_id,
                                                                  min(time::date) OVER(PARTITION BY courier_id) as date
                                                  FROM   courier_actions
                                                  ORDER BY 1) t5
                                          GROUP BY date
                                          ORDER BY date) t6 using (date)
ORDER BY date;