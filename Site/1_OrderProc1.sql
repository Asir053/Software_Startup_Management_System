SET SERVEROUTPUT ON;

create or replace procedure InsertOrderWithDiscount1(or_date IN Orders2.orders_date%TYPE,inp_c_id IN int,fixed_price IN int,rqrmntid IN int)
		IS
	c int:=0;
	D int:=0;
	B1 int:=0;
	B2 int:=0;
	F int:=0;
	G int:=0;
	EF1 int:=0;
	EF2 int:=0;
	client_not_found_ex EXCEPTION;
	PRAGMA EXCEPTION_INIT (client_not_found_ex, -20001);
	--or_date varchar2(30):='3-Dec-19';
	--inp_c_id int :=1;
	--fixed_price int:=7000;
--order insert with discount
BEGIN
	--select count(client.c_id) from client inner join orders on client.c_id=orders.c_id group by client. c_id having count(client.c_id)>2;
	--FOR R IN (select c_id as B2 from Client1@site_link2) LOOP
	--	D:=R.B2;
	--	if D!=inp_c_id then
	--		EF1 :=1;
	--		raise_application_error(-20001,'Client not found,try again!');
	--	end if;
	--end loop;
	--
	--
	--if EF1=1 then
	--	raise_application_error(-20001,'Client not found,try again!');
	--end if;
	
	
	FOR R IN (select or_id as B2 from orders1@site_link2) LOOP
		D:=R.B2;
	end loop;
	--global table thke cursor, local table a insert
	FOR R IN (select client1.c_id as B1,count(client1.c_id) as B2 from client1@site_link2 join orders1@site_link2 on client1.c_id=orders1.c_id group by client1.c_id having count(client1.c_id)>=2) LOOP
	 C := R.B1;
	 G := R.B2;
	 --B := R.B1;
	 if C=inp_c_id then
		insert into Orders1@site_link2 values (D+1,C,rqrmntid,or_date,0,fixed_price-(fixed_price*0.15)); 
		F:=1;
	 end if;
	 --DBMS_OUTPUT.PUT_LINE(C||' '||D||' '||B);
	END LOOP;
	
	FOR R IN (select or_id as B2 from orders1@site_link2) LOOP
		D:=R.B2;
	end loop;
	
	if F=0 then
		insert into Orders1@site_link2 values (D+1,inp_c_id,rqrmntid,or_date,0,fixed_price); 
	end if;
		
	
END InsertOrderWithDiscount1;
/

