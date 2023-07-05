select count(*)
  from customer;
  
select count(phone)
  from customer;
  
select count(custid)
  from customer;
 
 --������ �ֹ��� ������ �� ������ �� �Ǹž� 
  select custid, count(*) as ��������, sum(saleprice) as �Ѿ�
    from orders
group by custid
order by sum(saleprice) desc;

--�ֹ����̺��� �ǸŰ����� �����̻��� �ֹ��߿� ��id�� �׷�ȭ�ϰ� �� �߿� 3���� �̻��� �͵��� ��id, �� �Ǽ�, ���� �հ踦 �����հ� ������������ �����Ͽ���.
  select custid, count(*), sum(saleprice) 
    from orders
   where saleprice >= 10000
group by custid
  having sum(saleprice) >= 30000
order by sum(saleprice) desc;

-- ���ǻ���
-- 1) group by�� ����ϸ� select������ group by���� ������ �Ӽ��� �����Լ��� �� �� �ִ�.
  select bookid, custid, count(*)
    from orders
group by bookid, custid;

-- 2) having ���� ����ϸ� �˻����ǿ� �����Լ��� �;��Ѵ�.
  select custid, count(*), sum(saleprice)
    from orders
   where saleprice >= 10000
group by custid
having sum(saleprice) >= 30000;

--�������� 1-1) ������ȣ�� 1�� ������ �̸�
select bookname, bookid
  from book
 where bookid = 1;
 
--�������� 1-2) ������ 20,000�� �̻��� ������ �̸�
select bookname, saleprice
  from orders, book
 where saleprice > 20000;

--�������� 1-3) �������� �ѱ��ž�
 select sum(saleprice)
   from orders
  where custid = 1;
--�������� 1-4) �������� ������ ������ ��
  select count(*)
    from orders
   where custid = 1;
   
--�������� 2-1) ���缭�� ������ �Ѽ�
  select count(*)
    from book;

 