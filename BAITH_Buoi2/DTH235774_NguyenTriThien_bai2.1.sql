drop database QLSV
create database QLSV
on(
	name = QLSV_mdf,
	filename = 'D:\AGU\SQL_SERVER_UNI\BAITH_Buoi2\QLSV.mdf',
	size = 10,
	maxsize = 50,
	filegrowth = 5)
log on( 
	name = QLSV_ldf,
	filename = 'D:\AGU\SQL_SERVER_UNI\BAITH_Buoi2\QLSV\QLSV.ldf',
	size = 10,
	maxsize = 50,
	filegrowth = 5
	)
use QLSV
drop table SVIEN
create table SVIEN(
	TEN nvarchar(25) not null,
	MASV varchar(4) primary key check (MASV like '[a-z][0-9][0-9][0-9]'),
	NAM int,
	KHOA varchar(10) default ('CNTT')
)
drop table MHOC
create table MHOC(
	TEN_MH nvarchar(30),  
	MAMH varchar(6) primary key check (MAMH like '[a-z][a-z][a-z][0-9][0-9][0-9]'),
	SOTINCHI int check (SOTINCHI >=1 AND SOTINCHI <=10),
	KHOA varchar(10) default ('CNTT')
)
drop table DKIEN
create table DKIEN(
	MAMH varchar(6),
	MAMH_TRUOC varchar(6),
	primary key (MAMH, MAMH_TRUOC),
)
drop table HOCPHAN
create table HOCPHAN(
	MAHP int primary key check (MAHP >0),
	MAMH varchar(6),
	HOCKY int,
	NAMHOC varchar(10),
	GV nvarchar(25),
	foreign key (MAMH) references MHOC(MAMH)	
)
drop table KETQUA
create table KETQUA(
	MASV varchar(4),
	MAHP int,
	DIEM decimal (3,1) check (DIEM between 0 and 10),
	primary key(MASV, MAHP),	
	foreign key (MAHP) references HOCPHAN(MAHP),
	foreign key (MASV) references SVIEN(MASV)
)

insert into SVIEN values ('Nguyen Hong Son', 'A001', 1, 'SP')
insert into SVIEN values ('Le Chau Bao', 'B010', 2, 'CNTT')

insert into DKIEN values ('COS312', 'COS301')
insert into DKIEN values ('COS312', 'COS111')
insert into DKIEN values ('ENG102', 'ENG101')

insert into MHOC values ('Tin hoc đai cuong', 'COS301', 3, 'CNTT')
insert into MHOC values ('Cau truc du lieu', 'COS312', 3, 'CNTT')
insert into MHOC values ('Toan roi rac', 'COS111', 3, 'CNTT')
insert into MHOC values ('An van khong chuyen 1', 'ENG101', 3, 'SP')
insert into MHOC values ('An van khong chuyen 2', 'ENG102', 3, 'SP')

insert into HOCPHAN values (1, 'COS301', 1, '2010-2011', 'Kim')
insert into HOCPHAN values (2, 'COS111', 1, '2010-2011', 'Trong')
insert into HOCPHAN values (3, 'ENG101', 1, '2011-2012', 'Nam')
insert into HOCPHAN values (4, 'COS111', 2, '2011-2012', 'Duy')
insert into HOCPHAN values (5, 'ENG102', 2, '2011-2012', 'Phuc')
insert into HOCPHAN values (6, 'COS301', 2, '2011-2012', 'Thuy')

insert into KETQUA values ('A001', 1, 5.5)
insert into KETQUA values ('A001', 3, 8)
insert into KETQUA values ('B010', 1, 9)
insert into KETQUA values ('B010', 2, 7.5)
insert into KETQUA values ('B010', 3, 6)
insert into KETQUA values ('B010', 5, 8)
insert into KETQUA values ('B010', 6, 9)
insert into KETQUA values ('A001', 5, 9.5)

select * from SVIEN 
select * from MHOC 
select * from DKIEN 
select * from HOCPHAN 
select * from KETQUA 

