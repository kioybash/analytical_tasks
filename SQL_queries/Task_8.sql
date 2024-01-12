SELECT hour,
       successful_orders,
       canceled_orders,
       round((canceled_orders::decimal / orders), 3) as cancel_rate
FROM   (SELECT extract(hour
        FROM   creation_time)::integer as hour, count(order_id) as orders, count(order_id) filter(
        WHERE  order_id not in (SELECT order_id
                                FROM   user_actions
                                WHERE  action = 'cancel_order')) as successful_orders , count(order_id) filter(
        WHERE  order_id in (SELECT order_id
                            FROM   user_actions
                            WHERE  action = 'cancel_order')) as canceled_orders
        FROM   orders
        GROUP BY hour) t1;