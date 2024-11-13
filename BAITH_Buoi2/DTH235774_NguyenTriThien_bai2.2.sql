create database QLNV
on(
	name = QLNV_mdf,
	filename = 'D:\AGU\SQL_SERVER_UNI\BAITH_Buoi2\QLNV.mdf',
	size = 10,
	maxsize = 50,
	filegrowth = 5)
log on( 
	name = QLNV_ldf,
	filename = 'D:\AGU\SQL_SERVER_UNI\BAITH_Buoi2\QLNV.ldf',
	size = 10,
	maxsize = 50,
	filegrowth = 5
	)
use QLNV
drop table PHONG
create table PHONG(
	Maphg varchar(2) primary key,
	Tenphg nvarchar(64) unique not null
)
drop table CONGVIEC
create table CONGVIEC(
	Macv varchar(3) primary key, 
	Tencv nvarchar(64) unique not null
)
drop table NHANVIEN
create table NHANVIEN(
	Manv varchar(5) primary key check(Manv LIKE '[a-z][a-z][0-9][0-9][0-9]'),
	Holot nvarchar(10) unique not null,
	Ten nvarchar(10) unique not null,
	Luong int check (Luong>0),
	Phai char(3) default ('Nam'),
	Email varchar(64) unique check ( Email like '%@%'),
	Maphg varchar(2),
	Macv varchar(3),
	foreign key (Macv) references CONGVIEC(Macv),
	foreign key (Maphg) references PHONG(Maphg)
)

insert into PHONG values ('01', 'MT01')
insert into PHONG values ('02', 'MT02')

insert into CONGVIEC values ('cva', 'Quan li')
insert into CONGVIEC values ('cvb', 'iyfgft')

insert into NHANVIEN values ('nv001', 'Thien', 'Nguyen', 1000000, 'Nam', 'ntt@gmail.com', '02', 'cvb')




