select *
  from customer
 where name = '�迬��';
    
select phone "����ó"
  from customer
 where name = '�迬��';
    
    /* ������ �ּ� */
    --. ���� �ּ�
    -- 10000�� �̻��� ������ ������� ���ǻ纰 ���� �հ谡 20000�� �̻�
select publisher "���ǻ�" , sum(price) "�Ѱ�"
  from book
 where price >= 10000                         --���ڵ� ���͸�
   group by publisher                           --Ư�� �÷����� �׷����Ͽ� ����
    having sum(price) >= 20000                   --�׷����� ����� ���͸�
    order by publisher desc;                     --����
    
--���ǻ� ��� ����ϱ� ( �ߺ� ���� )
select distinct publisher
    from book;
    
select bookname, price
  from book; 

--��� ������ ������ȣ, �����̸�, ���ǻ�, ������ �˻��Ͻÿ�.
select bookid, bookname, publisher, price
  from book;
  
--���� ���̺� �ִ� ��� ���ǻ縦 �˻��Ͻÿ�
select publisher
  from book;
  
--�ߺ� ����
select distinct publisher
  from book;

--������ 20000�� �̸��� ������ �˻��Ͻÿ�
select *
  from book
 where price < 20000;
 
--å���� '�౸'�� �� å ����
select *
  from book
 where bookname like '%�౸%';
   
--������ �߿� �̾� ����
select *
  from customer
 where name like '��%';

select *
  from book
 where bookname like '_��%';