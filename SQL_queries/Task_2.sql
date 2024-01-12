SELECT date,
       new_users,
       new_couriers,
       total_users,
       total_couriers,
       round(((new_users - (lag(new_users) OVER(ORDER BY date)))::decimal / (lag(new_users) OVER(ORDER BY date)) * 100),
             2) as new_users_change,
       round(((new_couriers - (lag(new_couriers) OVER(ORDER BY date)))::decimal / (lag(new_couriers) OVER(ORDER BY date)) * 100),
             2) as new_couriers_change,
       round(((total_users - (lag(total_users) OVER(ORDER BY date)))::decimal / (lag(total_users) OVER(ORDER BY date)) * 100),
             2) as total_users_growth,
       round(((total_couriers - (lag(total_couriers) OVER(ORDER BY date)))::decimal / (lag(total_couriers) OVER(ORDER BY date)) * 100),
             2) as total_couriers_growth
FROM   (SELECT date,
               count(user_id) as new_users,
               sum(count(user_id)) OVER(ORDER BY date)::integer as total_users
        FROM   (SELECT DISTINCT user_id,
                                min(time::date) OVER(PARTITION BY user_id) as date
                FROM   user_actions
                ORDER BY 1) t1
        GROUP BY date
        ORDER BY date) t2 full join (SELECT date,
                                    count(courier_id) as new_couriers,
                                    sum(count(courier_id)) OVER(ORDER BY date)::integer as total_couriers
                             FROM   (SELECT DISTINCT courier_id,
                                                     min(time::date) OVER(PARTITION BY courier_id) as date
                                     FROM   courier_actions
                                     ORDER BY 1) t3
                             GROUP BY date
                             ORDER BY date) t4 using (date)
ORDER BY date;