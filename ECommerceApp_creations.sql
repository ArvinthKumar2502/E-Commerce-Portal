--Table Creations
create table customers_list(
  cust_no number(3),
  cust_uname VARCHAR(30),
  cust_pwd VARCHAR(30) not NULL,
  cust_age number(2) not NULL,
  cust_gender char(1) not NULL,
  cust_mobno number(10) not NULL,
  address VARCHAR2(60) not NULL,
  city varchar(20) not NULL,
  CONSTRAINT samp_cust_pk primary key(cust_uname)
);

create table category(
  category_id VARCHAR2(5),
  category_Name VARCHAR2(20) not NULL,
  no_products number(4) not NULL,
  constraint category_pk primary key(CATEGORY_ID)
  );



create table products(
  cat_id VARCHAR2(5),
  pdt_id NUMBER(4),
  pdt_name varchar(20),
  pdt_price number(7) not NULL,
  pdt_rating number(2,1) not NULL,
  no_stock number(3) not NULL,
  constraint product_pk primary key(PDT_NAME),
  constraint product_fk_pdtname foreign key(cat_ID) references CATEGORY(CATEGORY_ID)
);


create table PURCHASES(
  purchase_no number(3), 
  username varchar(30),
  noProducts number(3),
  TotalAmount number(10),
  Purchase_date date,
  CONSTRAINT purchases_fk_uname foreign key(username) references CUSTOMERS_LIST(CUST_UNAME)
);


CREATE TABLE Cart_items(
  CUST_USERNAME varchar(30),
  PRODUCT_NAME varchar(30),
  DATE_ADDED DATE,
  CONSTRAINT cartitems_fk_uname foreign key(cust_username) references CUSTOMERS_LIST(CUST_UNAME),
  CONSTRAINT cartitems_fk_pdt_name foreign key(PRODUCT_NAME) references products(PDT_NAME)
);


--Table Insertions

insert into CATEGORY values('CA1','Mobiles',180);
insert into CATEGORY values('CA2','Books',180);
insert into CATEGORY values('CA3','Watches',180);
insert into CATEGORY values('CA4','Shoes',180);
insert into CATEGORY values('CA5','Computers',210);
insert into CATEGORY values('CA6','Clothes',200);


insert into Products values('CA1',product_id_sequence.nextval,'iPhone 11',55000,4.6,30);
insert into Products values('CA1',product_id_sequence.nextval,'iPhone 11 Pro',65000,4.3,30);
insert into Products values('CA1',product_id_sequence.nextval,'Nokia 8',40000,4.2,30);
insert into Products values('CA1',product_id_sequence.nextval,'Nokia 8.2',25000,4.0,30);
insert into Products values('CA1',product_id_sequence.nextval,'Pixel 4',40000,3.9,30);
insert into Products values('CA1',product_id_sequence.nextval,'Pixel 4XL',45000,4.0,30);


insert into Products values('CA2',product_id_sequence.nextval,'Adventures of TinTin',3500,3.1,30);
insert into Products values('CA2',product_id_sequence.nextval,'Chronicles of Narnia',4500,3.5,30);
insert into Products values('CA2',product_id_sequence.nextval,'Harry Potter I-IX',3800,3.7,30);
insert into Products values('CA2',product_id_sequence.nextval,'PSJAVA Fundamental',5500,3.9,30);
insert into Products values('CA2',product_id_sequence.nextval,'Quentin SQL Basics',6500,3.9,30);
insert into Products values('CA2',product_id_sequence.nextval,'Xav AWT Fundamental',3500,4.6,30);

insert into Products values('CA3',product_id_sequence.nextval,'Casio CSB3',3000,4.3,30);
insert into Products values('CA3',product_id_sequence.nextval,'Casio C4T',4000,4.5,30);
insert into Products values('CA3',product_id_sequence.nextval,'Fastrack FZ1',5500,4.6,30);
insert into Products values('CA3',product_id_sequence.nextval,'Seiko SSB2',3800,3.8,30);
insert into Products values('CA3',product_id_sequence.nextval,'Seiko SZX',6900,4.8,30);
insert into Products values('CA3',product_id_sequence.nextval,'Rolex RT5',4900,4.2,30);

insert into Products values('CA4',product_id_sequence.nextval,'Adidas A23',3500,3.5,30);
insert into Products values('CA4',product_id_sequence.nextval,'Adidas A6YH',4000,3.8,30);
insert into Products values('CA4',product_id_sequence.nextval,'FILA FG56',5000,3.9,30);
insert into Products values('CA4',product_id_sequence.nextval,'FILA 112Z',5500,4.1,30);
insert into Products values('CA4',product_id_sequence.nextval,'Puma P25',5300,4.4,30);
insert into Products values('CA4',product_id_sequence.nextval,'Puma P67',6000,4.8,30);

insert into Products values('CA5',product_id_sequence.nextval,'Dell G3',60000,4.6,30);
insert into Products values('CA5',product_id_sequence.nextval,'HP Pavilion x360',80000,4.8,30);
insert into Products values('CA5',product_id_sequence.nextval,'HP ENVY x360',75000,4.7,30);
insert into Products values('CA5',product_id_sequence.nextval,'MacBook Air',70000,4.9,30);
insert into Products values('CA5',product_id_sequence.nextval,'MacBook Pro',60000,4.4,30);
insert into Products values('CA5',product_id_sequence.nextval,'Sandisk Pendrive',900,4.9,30);
insert into Products values('CA5',product_id_sequence.nextval,'SeaGate Ext-Harddisk',3900,4.8,30);

insert into Products values('CA6',product_id_sequence.nextval,'Casual Shirts',3000,4.5,50);
insert into Products values('CA6',product_id_sequence.nextval,'Formal Shirts',2000,4.7,50);
insert into Products values('CA6',product_id_sequence.nextval,'Denim Jeans',2500,4.1,50);
insert into Products values('CA6',product_id_sequence.nextval,'T Shirts',4000,4.8,50);


--Display Tables

select * from customers_list;
select * from category;
select * from Products;
SELECT * from PURCHASES;
SELECT * from CART_ITEMS;

--Drop Tables
drop table customers_list;
drop table CATEGORY;
drop table PRODUCTS;
drop table purchases;
drop table CART_ITEMS;

drop sequence purchase_no_sequence;
drop sequence customer_no_sequence;

--Describe TABLES
desc CUSTOMERS_LIST;
desc category;
DESC PRODUCTS;
DESC PURCHASES;
desc CART_ITEMS;


--Sequence Creations

CREATE SEQUENCE purchase_no_sequence
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE
NOCYCLE;

CREATE SEQUENCE customer_no_sequence
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE
NOCYCLE;

CREATE SEQUENCE product_id_sequence
START WITH 101
INCREMENT BY 1
NOMAXVALUE
NOCACHE
NOCYCLE;


--Trigger Creation
create or replace trigger modify_category_count 
after insert or update or DELETE
on PRODUCTS 
DECLARE
  c_p_count  products.NO_STOCK%type;
  cursor c_manage_pdt_count_cat1 is select SUM(no_stock) FROM Products where CAT_ID='CA1';
  cursor c_manage_pdt_count_cat2 is select SUM(no_stock) FROM Products where CAT_ID='CA2';
  cursor c_manage_pdt_count_cat3 is select SUM(no_stock) FROM Products where CAT_ID='CA3';
  cursor c_manage_pdt_count_cat4 is select SUM(no_stock) FROM Products where CAT_ID='CA4';
  cursor c_manage_pdt_count_cat5 is select SUM(no_stock) FROM Products where CAT_ID='CA5';
  cursor c_manage_pdt_count_cat6 is select SUM(no_stock) FROM Products where CAT_ID='CA6';

  BEGIN 
    --for category 1
    open c_manage_pdt_count_cat1;
      LOOP 
        Fetch c_manage_pdt_count_cat1 into c_p_count;
        EXIT when c_manage_pdt_count_cat1%notfound;
      END LOOP;
    close c_manage_pdt_count_cat1;
    update category set Category.NO_PRODUCTS=c_p_count WHERE Category.CATEGORY_ID='CA1';

    --for category 2
    open c_manage_pdt_count_cat2;
      LOOP 
        Fetch c_manage_pdt_count_cat2 into c_p_count;
        EXIT when c_manage_pdt_count_cat2%notfound;
      END LOOP;
    close c_manage_pdt_count_cat2;
    update category set Category.NO_PRODUCTS=c_p_count WHERE Category.CATEGORY_ID='CA2';

    --for category 3
    open c_manage_pdt_count_cat3;
      LOOP 
        Fetch c_manage_pdt_count_cat3 into c_p_count;
        EXIT when c_manage_pdt_count_cat3%notfound;
      END LOOP;
    close c_manage_pdt_count_cat3;
    update category set Category.NO_PRODUCTS=c_p_count WHERE Category.CATEGORY_ID='CA3';

    --for category 4
    open c_manage_pdt_count_cat4;
      LOOP 
        Fetch c_manage_pdt_count_cat4 into c_p_count;
        EXIT when c_manage_pdt_count_cat4%notfound;
      END LOOP;
    close c_manage_pdt_count_cat4;
    update category set Category.NO_PRODUCTS=c_p_count WHERE Category.CATEGORY_ID='CA4';

    --for category 5
    open c_manage_pdt_count_cat5;
      LOOP 
        Fetch c_manage_pdt_count_cat5 into c_p_count;
        EXIT when c_manage_pdt_count_cat5%notfound;
      END LOOP;
    close c_manage_pdt_count_cat5;
    update category set Category.NO_PRODUCTS=c_p_count WHERE Category.CATEGORY_ID='CA5';

    --for category 6
    open c_manage_pdt_count_cat6;
      LOOP 
        Fetch c_manage_pdt_count_cat6 into c_p_count;
        EXIT when c_manage_pdt_count_cat6%notfound;
      END LOOP;
    close c_manage_pdt_count_cat6;
    update category set Category.NO_PRODUCTS=c_p_count WHERE Category.CATEGORY_ID='CA6';
END;



--Table value DELETIONS
DELEte FROM CUSTOMERS_LIST;
DELETE FROM CATEGORY;
delete from products;
delete from purchases;
delete from cart_items;



--Index Creations

--index for customers' username of CART_ITEMS table
CREATE INDEX Transactions_UName_Index 
ON CART_ITEMS(CUST_USERNAME);

--index for products purchased of CART_ITEMS table
CREATE INDEX Transactions_PdtName_Index 
ON CART_ITEMS(PRODUCT_NAME);

--index for date of purchase of CART_ITEMS table
CREATE INDEX Transactions_Date_Index 
ON CART_ITEMS(DATE_ADDED);


--Query to fetch most demanding products
select PRODUCT_NAME,count(product_name) 
from cart_items GROUP BY(CART_ITEMS.PRODUCT_NAME) 
ORDER BY(count(product_name)) DESC FETCH FIRST 5 ROWS ONLY;




select *  from dba_indexes; 
where table_name='CART_ITEMS';

desc Transactions_Date_Index;

select * from sys_index;

SELECT  *
FROM    all_indexes
WHERE   table_name = 'CART_ITEMS';