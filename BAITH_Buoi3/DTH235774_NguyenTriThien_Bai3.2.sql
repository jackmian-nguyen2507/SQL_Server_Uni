--Bài 2 (Dùng CSDL QLBS ở buổi 1):
--1. Attach CSDL QLBS
--2. Tạo bảng ChamCongNV có cấu trúc giống bảng Nhanvien


create table ChamCongNV(
	MaNV char(5) primary key,
	HoLot varchar(25),
	TenNV varchar(10),
	Phai char(3) check(Phai in ('Nam','Nu')),
	NgaySinh date,
	DiaChi nvarchar(40)
)


--3. Chèn thêm cột NgayCong, DonGiaGiaCong (có kiểu số nguyên) vào bảng ChamCongNV
alter table ChamCongNV add NgayCong int, DonGiaGiaCong int


--Kiểm tra bảng ChamCongNV sau khi thêm
select * from ChamCongNV

 
--4. Xóa các cột HoLot, Tennv, Phai, NgaySinh, DiaChi trong bảng ChamCongNV

-- Xóa ràng buộc trước khi thực hiện xóa thuộc tính
alter table ChamCongNV drop constraint CK__ChamCongNV__Phai__628FA481

alter table ChamCongNV drop column HoLot,TenNV,Phai,NgaySinh,DiaChi

--Kiểm tra bảng ChamCongNV sau khi xóa
select * from ChamCongNV

--5. Thêm vào bảng Hoadon cột NGAYLAPHD (kiểu char(10))
alter table HoaDon add NGAYLAPHD char(10)

--6. Hiệu chỉnh kiểu dữ liệu cho cột vừa thêm thành kiểu datetime.
alter table HoaDon alter column NGAYLAPHD datetime

--7. Đổi tên cơ sở dữ liệu thành HOTENSV_SOMAY
--ALTER DATABASE QLBanSach SET SINGLE_USER WITH ROLLBACK IMMEDIATE
alter database QLBanSach modify name = NguyenTriThien_LapTop
--ALTER DATABASE HOTENSV_SOMAY SET MULTI_USER

exec sp_renamedb 'QLBanSach','NguyenTriThien_LapTop'

--8. Đổi tên bảng ChamCongNV thành Bangluong.
 
exec sp_rename 'ChamCongNV','Bangluong'

--9. Xóa Bangluong khỏi cơ sở dữ liệu.

drop table Bangluong

--10. Xóa bảng Hoadon khỏi CSDL, có thực hiện được không? Giải thích. Cách nào để xóa bảng
--HoaDon?

drop table Hoadon
-- Không xóa được vì


-- LỆNH UPDATE

--11. Cập nhật đơn giá 30000 cho mã sách S001
update Sach set DonGia = 30000 where MaSach ='S001'

--Kiểm tra sau khi cập nhật
select * from Sach 

--12. Cập nhật số lượng tồn = 50% số lượng tồn hiện có cho những cuốn sách thuộc mã nhóm
--N002
update Sach set SLTon = SLTon*0.5 where MaLoai = 'N002'

--Kiểm tra sau khi cập nhật
select * from Sach 

--13. Cập nhật mã loại N001 trong bảng LOAISACH thành N100? Có cập nhật được hay không?
--Vì sao?
update Sach set Maloai = 'N100' where Maloai = 'N001' --Khong update dc vi khoa ngoai

--Kiểm tra sau khi cập nhật
select * from Sach 

--14. Tăng đơn giá các danh mục sách lên 3%
update Sach set DonGia = DonGia*1.03

--Kiểm tra sau khi cập nhật
select * from Sach 

--15. Giảm 10% đơn giá cho loại sách Anh văn.
update Sach set DonGia = DonGia*0.9 where TenSach = 'Anh van'

--Kiểm tra sau khi cập nhật
select * from Sach 

--16. Thêm vào cột GIABAN trong bảng CTHD. Cập nhật giá bán bằng với đơn giá trong bảng SACH.
alter table CTHD add GIABAN int
update CTHD set GIABAN = DonGia from CTHD,Sach where CTHD.MaSach = Sach.MaSach

--Kiểm tra sau khi cập nhật
select * from CTHD 


--17. Thêm vào cột NGAYVAOLAM, kiểu date trong bảng Nhanvien. Cập nhật ngày vào làm cho nhân viên = Năm sinh +18.
alter table NhanVien add NGAYVAOLAM date 

--Kiểm tra sau khi cập nhật
select * from NhanVien 

-/*18. Thêm vào cột PhuCap, kiểu int trong bảng Nhanvien. Cập nhật phụ cấp cho những nhân
viên có thâm niên từ 10 năm trở lên (thâm niên được tính = năm hiện tại – năm vào làm).
Phụ cấp = 100.000 * thâm niên.*/
update NhanVien set NGAYVAOLAM = DATEADD(YEAR, 18, NgaySinh)
alter table NhanVien add PhuCap int 
alter table NhanVien add ThamNien int 
update NhanVien set ThamNien = DATEDIFF(YEAR, NgayVaoLam, GETDATE())
update NhanVien set PhuCap = 100000*ThamNien

--Kiểm tra sau khi cập nhật
select * from NhanVien 

-- LỆNH INSERT

--19. Thêm vào bảng LOAISACH (‘N007’, ‘Sức khỏe và đời sống’)
insert into LoaiSach (MaLoai,TenLoai) values ('N007','Suc khoe va doi song')

--20. Thêm vào bảng CTHD với số hóa đơn 6, mã sách S001 với số lượng 5 và S002 với số lượng 
insert into CTHD(MaHD,MaSach,SoLuong) values (6,'S001',5) 
insert into CTHD(MaHD,MaSach,SoLuong) values (5,'S002',20) --Không thêm được vì trùng lặp

/*21. Thêm vào bảng SACH với mã sách S011, tên sách là ‘Cánh đồng bất tận’, tác giả ‘Nguyễn
Ngọc Tư’, mã loại N006, đơn giá 45000, số lượng tồn 5.*/
insert into SACH(MaSach,TenSach,TacGia,MaLoai,DonGia,SLTon) 
	values ('S011','Canh dong bat tan','Nguyen Ngoc Tu','N006',45000,5)

/*22. Thêm vào bảng SACH với mã sách S011, tên sách là ‘Hỏi đáp sức khỏe’, tác giả ‘Đỗ Hồng
Ngọc’, mã loại N008, đơn giá 25000, số lượng tồn 50. Hãy quan sát lỗi (nếu có) và giải
thích?*/

insert into SACH(MaSach,TenSach,TacGia,MaLoai,DonGia,SLTon) 
	values ('S011','Hoi Dap Suc khoe','Nguyen Ngoc Tu','N008',25000,50) --Trung ma sach

--Kiểm tra sau khi thêm thông tin
select * from LoaiSach 
select * from CTHD 
select * from SACH 


-- LỆNH DELETE

--23. Xóa loại sách ‘N007’ trong bảng LOAISACH
delete from LOAISACH where MaLoai = 'N007'

--24. Xóa Hoadon số 6 trong bảng Hoadon. Hãy quan sát lỗi (nếu có) và giải thích?
delete from HoaDon where MaHD = 6
-- Phải xóa ở CTHD trước vì mỗi CTHD phải có một hóa đơn tương ứng 

--Kiểm tra sau khi xóa thông tin

select * from LOAISACH 
select * from HoaDon 
