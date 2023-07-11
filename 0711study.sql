--���� 4-3 ���� ����ֹ��ݾ��� ��������� �ݿø��� ���� ���Ͻÿ�.
  select custid "����ȣ", round(sum(saleprice)/count(*),-2) "��ձݾ�"
    from orders
group by custid;
--���� 4-4 ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� ���� ����� ���̽ÿ�.
  select bookid, replace(bookname, '�߱�','��') bookname, publisher, price
    from book;
--���� 4-5 �½��������� ������ ������ ����� ������ ���� ��, ����Ʈ���� ���̽ÿ�
  select bookname "����", length(bookname) "���ڼ�",
         lengthb(bookname) "����Ʈ��"
    from book
   where publisher = '�½�����';
--���� 4-6 ���缭���� �� �� ���� ���� ���� ����� ����̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
  select substr(name,1,1) "��", count(*) "�ο�"
    from customer
group by substr(name,1,1);
--���� 4-7 ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�
  select orderid "�ֹ���ȣ", orderdate "�ֹ���", orderdate+10 "Ȯ����"
    from orders;

--���� 4-8 ���缭���� 2020�� 7��7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. 'yyyy-mm-dd'����
  select orderid "�ֹ���ȣ", TO_CHAR(orderdate,'yyyy-mm-dd dy')"�ֹ���",
         custid "����ȣ", bookid "������ȣ"
    from orders
   where orderdate = to_date('20200707','yyyymmdd');

    
  select to_char(sysdate,'yyyy/mm/dd')
    from dual;
  select last_day(sysdate)
    from dual;
  select sysdate, systimestamp
    from dual;
  select ltrim(' page_1  ') "1"
    from dual;
  select next_day(sysdate,'��')
    from dual;
  select to_char(round(sysdate),'yyyy-mm-dd hh24,mi,ss')
    from dual;
  select decode (1,1,'����','�ٸ���')
    from dual;
  select decode(30,10,'�����Խ���',
                   20,'QnA',
                   30,'��������','����')
    from dual;
  select name,phone
    from customer;
  select nvl2(null,1,2),nvl2(1,1,2)
    from dual;
    
  select cs.name, sum(od.saleprice) "total"
    from (select  custid, name
            from  customer
           where  custid<=2)cs,
          orders  od
   where cs.custid=od.custid
group by cs.name;

--�������� 1) ���� �����̵�, ���ּ�, �Ǹž��� ���̽ÿ�.
  select custid, (select  address
                    from  customer cs
                   where  cs.custid = od.custid) "address",
                          sum(saleprice) "total"
    from orders od
group by od.custid;

--�������� 2) ���� ���̸�, ��� �Ǹž��� ���̽ÿ�.
  select cs.name,s
    from (select custid,avg(saleprice)s
            from orders
        group by custid)od, customer cs
   where cs.custid = od.custid;
   
--�������� 3) ����ȣ�� 3������ ���� ������� �Ǹ� �Ѿ��� ���̽ÿ�
  select sum(saleprice) "total"
    from orders od
   where exists (select *
                   from customer cs
                  where custid <= 3 and cs.custid = od.custid); 