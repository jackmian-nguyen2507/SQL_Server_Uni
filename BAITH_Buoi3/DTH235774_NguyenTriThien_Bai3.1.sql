/* Buổi 3: Lệnh DML
--Bài 1(Dúng CSDL QLSV ở buổi 2
*/

-- Thêm vào bảng SVIEN cột 
-- a, cột Dthoai kiểu varchar
-- b, cột Phai char(3):  chi chap nhan 1 trong 2 giá trị ‘nam’ hoặc ‘nu’ 
alter table SVIEN add Dthoai varchar(9), Phai char(3) check (phai in ('Nam','Nu'))

-- Kiểm tra đã thêm cột thành công chưa
select * from SVIEN

-- Sửa cột Dthoai có kiểu dữ liệu mới là varchar(11) và không được trùng nhau.
alter table SVIEN alter column Dthoai varchar(11)

update SVIEN set Dthoai = '0944579658', Phai = 'Nam' where MASV = 'B010'
update SVIEN set Dthoai = '0966459448', Phai = 'Nu' where MASV = 'A001'

alter table SVIEN add constraint uq_dthoai unique (dthoai)

-- Cập nhật số điện thoại của A001 thành ‘01234111222’

update SVIEN set Dthoai = '01234111222' where MASV = 'A001'


--Xóa bỏ cột Dthoai đã thêm vào trên bảng SVIEN. 

alter table SVIEN drop constraint uq_dthoai
alter table SVIEN drop column Dthoai

--Thêm 1 sinh viên: (‘Phan Quoc Tuan’, ‘B012’,1, nam) 
insert into SVIEN(ten,masv,nam,phai) values ('Phan Quoc Tuan', 'B012', 1,'Nam')

--Kiểm tra sinh viên vừa thêm
select * from SVIEN


--Thêm 1 học phần (HOCPHAN) mới (7, ‘COS301’,1,2011-2012,Van) 
insert into HOCPHAN(mahp,mamh,hocky,NAMHOC,gv) values (7, 'COS301',1,'2011-2012','Van')

--Kiểm tra học phần vừa xem
select * from HOCPHAN

--Thêm vào bảng KETQUA (‘B012’, 7, 9) 
insert into KETQUA(masv,mahp,diem) values ('B102',7,9)

--Kiểm tra kết quả vừa xem
select * from KETQUA

--Sửa tên của ‘Phan Quoc Tuan’ thành ‘Pham Quoc Tuan’ và năm thành 2 
update SVIEN set Ten = 'Pham Quoc Tuan' , nam = 2 where ten = 'Phan Quoc Tuan'

-- Kiểm tra thông tin vừa sửa
select * from SVIEN

--Sửa điểm thi học phần 7 của ‘Pham Quoc Tuan’ thành 9.5
update KETQUA set DIEM = 9.5 where MAHP = 7 and MASV=(select MASV
														from SVIEN
														where ten = 'Pham Quoc Tuan')

-- Kiểm tra điểm thi vừa sửa
select * from KETQUA 
 
-- Xóa sv có mã số B012, xóa kết quả của sv B012, xóa môn COS301 trong hk 1 năm 2011-2012 
alter 	
delete from SVIEN where masv = 'B102'
delete from KETQUA where masv = 'B102'
delete from HOCPHAN where mamh = 'COS301' and hocky = 1 and Namhoc = '2011-2012'

--Kiểm tra sinh viên đã được xóa ra khỏi csdl chưa
select * from SVIEN
select * from HOCPHAN
select * from KETQUA 

--Thực hiện các lệnh ở mục 2.5 trên bảng KETQUA, HOCPHAN 

sp_help KETQUA 
sp_pkeys KETQUA 
sp_fkeys KETQUA 

sp_help HOCPHAN 
sp_pkeys HOCPHAN 
sp_fkeys HOCPHAN 