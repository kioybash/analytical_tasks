SELECT date,
       (avg(deliver_time - accept_time) / 60)::integer as minutes_to_deliver
FROM   (SELECT order_id,
               date(time) as date,
               min(extract(epoch
        FROM   time)) filter(
        WHERE  action = 'accept_order') as accept_time, min(extract(epoch
        FROM   time)) filter(
        WHERE  action = 'deliver_order') as deliver_time
        FROM   courier_actions
        GROUP BY order_id, date) t1
GROUP BY date
ORDER BY date;