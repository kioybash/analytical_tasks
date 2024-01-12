SELECT date,
       round(paying_users::decimal / active_couriers, 2) as users_per_courier,
       round(orders::decimal / active_couriers, 2) as orders_per_courier
FROM   (SELECT date(time) as date,
               count(distinct courier_id) as active_couriers
        FROM   courier_actions
        WHERE  order_id not in (SELECT order_id
                                FROM   user_actions
                                WHERE  action = 'cancel_order')
        GROUP BY date) t1 join (SELECT date(time) as date,
                               count(distinct user_id) as paying_users
                        FROM   user_actions
                        WHERE  order_id not in (SELECT order_id
                                                FROM   user_actions
                                                WHERE  action = 'cancel_order')
                        GROUP BY date) t2 using (date) join (SELECT date(time) as date,
                                            count(order_id) as orders
                                     FROM   user_actions
                                     WHERE  order_id not in (SELECT order_id
                                                             FROM   user_actions
                                                             WHERE  action = 'cancel_order')
                                     GROUP BY date) t3 using (date);