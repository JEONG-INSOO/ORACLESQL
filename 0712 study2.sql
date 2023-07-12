  CREATE view vw_theater_customer as 
  select th.theater_name,
         cs.name
    from theater th, customer cs, reservation rv
   where th.theater_no = rv.theater_no
     and cs.cust_no = rv.cust_no;
  
  CREATE view vw_daehan_customer_count as 
  select count(rv.cust_no) cnt,
         rv.screening_date,
         th.theater_name
    from theater th, reservation rv
   where th.theater_no = rv.theater_no
     and theater_name like '대한'
group by rv.screening_date, th.theater_name;
     
  CREATE view vw_thrv as
  select th.theater_name, count(rv.cust_no) cnt
    from theater th, reservation rv
   where th.theater_no = rv.theater_no
group by th.theater_name;

  select *
    from reservation;
    
  select count(rv.cust_no)
    from reservation rv, theater th
   where th.theater_name = '강남';
   
  select min(count(rv.cust_no))
    from reservation;
