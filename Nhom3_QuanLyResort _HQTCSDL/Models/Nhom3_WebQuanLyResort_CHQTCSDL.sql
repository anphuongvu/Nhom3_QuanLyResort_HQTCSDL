----------------- Vũ Phương An _ 19DH110766 -----------------------------------------------------------------
use master
go
drop database QLResort
create database QLResort
On Primary
(
	Name=QLResort_Data,
	FileName= 'E:\Năm 4\CacHeQuanTriCSDL\DoAn\QLResort.mdf',
	Size= 250MB,
	MaxSize = Unlimited,
	FileGrowth= 10MB
),
FILEGROUP QLResort_FG1
(
	Name='QLResort_FG1_Dat1_01.ndf',
	FileName='E:\Năm 4\CacHeQuanTriCSDL\DoAn\QLResort.ndf',
	Size= 25MB,
	MaxSize= 50MB,
	FileGrowth= 10MB
)
LOG ON
(
	Name= QLResort_log,
	FileName='E:\Năm 4\CacHeQuanTriCSDL\DoAn\QLResort.ldf',
	Size= 250MB,
	MaxSize= 500MB,
	FileGrowth= 10MB
);
-----------------------
use QLResort
go
--------------------------
--- 1. Tạo bảng Khách Hàng
create table KhachHang
(
	MaKH smallint IDENTITY(1,1) NOT NULL,
	HoTen nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	GioiTinh nvarchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SoCMND bigint NOT NULL,
	SDT int NOT NULL,
	QuocTich nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	NgaySinh smalldatetime,
	MaTaiKhoan smallint  NULL	
) On [Primary]
Go
--- 2. Tạo bảng Tài Khoản
create table TaiKhoan
(
	MaTaiKhoan smallint IDENTITY(1,1) NOT NULL,
	UserName nvarchar(150) NOT NULL,
	Passwordd nvarchar(150) NOT NULL,
	MaPQ smallint NULL,
	MaKH smallint NULL,
	MaNV smallint  NULL
) On [Primary]
Go
--- 3. Tạo bảng Phân Quyền
create table PhanQuyen
(
	MaPQ smallint IDENTITY(1,1) NOT NULL,
	TenPQ nvarchar(10) NOT NULL
) On [Primary]
Go
--- 4. Tạo bảng Nhân Viên
create table NhanVien
(
	MaNV smallint IDENTITY(1,1) NOT NULL,
	HoTen nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	GioiTinh nvarchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	NgaySinh smalldatetime,
	DiaChi nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	MaChucVu smallint NOT NULL,
	MaTaiKhoan smallint  NULL
) On [Primary]
Go
--- 5. Tạo bảng Chức Vụ
create table ChucVu
(
	MaChucVu smallint IDENTITY(1,1) NOT NULL,
	TenChucVu nvarchar(20) NOT NULL,
) On [Primary]
Go
--- 6. Tạo bảng Loại Phòng
create table LoaiPhong
(
	MaLoai smallint NOT NULL,
	TenLoai nvarchar(255) NOT NULL,
	ChiTiet nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) On [Primary]
Go
--- 7. Tạo bảng Đơn Giá Phòng
create table DonGiaPhong
(
	MaPhong smallint NOT NULL,
	MaLoai smallint NOT NULL,
	DonGia decimal(18,2) NOT NULL
) On [Primary]
Go
--- 8. Tạo bảng Phương Thức Thanh Toán
create table PhuongThucThanhToan
(
	MaPhuongThuc smallint IDENTITY(1,1) NOT NULL,
	TenPhuongThuc nvarchar(50) NOT NULL,
) On [Primary]
Go
--- 9. Tạo bảng Đặt Phòng
create table DatPhong
(
	MaDatPhong smallint IDENTITY(1,1) NOT NULL,
	MaPhong smallint NOT NULL,
	MaPhuongThuc smallint NOT NULL,
	MaPhieuXacNhan smallint  NULL,
	TenKH nvarchar(50) NOT NULL,
	NgayDatPhong smalldatetime,
	NgayTraPhong smalldatetime,
	YeuCauThem nvarchar(255) NULL
) On [Primary]
Go
--- 10. Tạo bảng Checkin_Checkout
create table CheckInOut
(
	MaDatPhong smallint NOT NULL,
	TenKH nvarchar(50) NOT NULL,
	NgayDatPhong smalldatetime,
	NgayTraPhong smalldatetime,
	PhiThuThem DECIMAL(18,2) Null,
	TrangThai bit NULL,
	MaNV smallint NOT NULL,
) On [Primary]
Go
--- 11. Tạo bảng Dịch Vụ
create table DichVu
(
	MaDichVu smallint  IDENTITY(1,1) NOT NULL,
	TenDichVu nvarchar(50) NOT NULL,
	LoaiDichVu nvarchar(50) NULL,
	NgayBatDau smalldatetime,
	NgayKetThuc smalldatetime
) On [Primary]
Go
--- 12. Tạo bảng Đặt dịch vụ
create table DatDichVu
(
	MaPhong smallint NOT NULL,
	MaDichVu smallint NOT NULL,
	SoLuong int NOT NULL
) On [Primary]
Go
--- 13. Tạo bảng Tiện ích Resort
create table TienIchResort
(
	MaTienIch smallint IDENTITY(1,1) NOT NULL,
	TenTienIch nvarchar(150) NOT NULL,
) On [Primary]
Go
--- 14. Tạo bảng Đặt tiện ích Resort
create table DatTienIchResort
(
	MaPhong smallint NOT NULL,
	MaTienIch smallint NOT NULL,
	TenKH nvarchar(50) NOT NULL,
) On [Primary]
Go
--- 15. Tạo bảng Thống kê doanh thu
create table ThongKeDoanhThu
(
	MaThongKe smallint IDENTITY(1,1) NOT NULL,
	ThangThongKe smalldatetime NOT NULL,
	NgayBatDau smalldatetime,
	NgayKetThuc smalldatetime,
	ChiTiet nvarchar(255),
	MaNV smallint NOT NULL,
	TongDoanhThu decimal(18,2)
) On [Primary]
Go
--- 16. Tạo bảng Phiếu xác nhận đặt phòng
create table PhieuXacNhanDatPhong
(
	MaPhieuXacNhan smallint IDENTITY(1,1) NOT NULL,
	MaDatPhong smallint NOT NULL,
	TenKH nvarchar(50) NOT NULL,
	YeuCauThem nvarchar(255) NULL,
	DonGia decimal(18,2) NOT NULL,
	NgayDatPhong smalldatetime,
	NgayTraPhong smalldatetime,
	TrangThaiDatPhong nvarchar(25) NOT NULL,
	MaPhuongThuc smallint NOT NULL
) On [Primary]
Go
--- 17. Tạo bảng Phòng
create table Phong
(
	MaPhong smallint NOT NULL,
	MaLoai smallint NOT NULL,
	SoGiuong smallint NOT NULL,
	HinhAnh nvarchar(max) NULL,
	DonGia decimal(18,2),
	MoTaThongTin nvarchar(max),
	TrangThai nvarchar(25) NOT NULL
) On [Primary]
Go
-------------------------------------------------
--- Tạo khóa chính
--- 1. Tạo khóa chính bảng Phân Quyền
ALTER TABLE PhanQuyen with nocheck ADD
	constraint PK_PhanQuyen PRIMARY KEY CLUSTERED
	(
		MaPQ
	) ON [Primary]
GO
--- 2. Tạo khóa chính bảng Loại Phòng
ALTER TABLE LoaiPhong with nocheck ADD
	constraint PK_LoaiPhong PRIMARY KEY CLUSTERED
	(
		MaLoai
	) ON [Primary]
GO
--- 3. Tạo khóa chính bảng Dịch Vụ
ALTER TABLE DichVu with nocheck ADD
	constraint PK_DichVu PRIMARY KEY CLUSTERED
	(
		MaDichVu
	) ON [Primary]
GO
--- 4. Tạo khóa chính bảng Tiện ích Resort
ALTER TABLE TienIchResort with nocheck ADD
	constraint PK_TienIchResort PRIMARY KEY CLUSTERED
	(
		MaTienIch
	) ON [Primary]
GO
--- 5. Tạo khóa chính bảng Tài Khoản
ALTER TABLE TaiKhoan with nocheck ADD
	constraint PK_TaiKhoan PRIMARY KEY CLUSTERED
	(
		MaTaiKhoan
	) ON [Primary]
GO
--- 6. Tạo khóa chính bảng Chức vụ
ALTER TABLE ChucVu with nocheck ADD
	constraint PK_ChucVu PRIMARY KEY CLUSTERED
	(
		MaChucVu
	) ON [Primary]
GO
--- 7. Tạo khóa chính bảng Thổng kê doanh thu
ALTER TABLE ThongKeDoanhThu with nocheck ADD
	constraint PK_ThongKeDoanhThu PRIMARY KEY CLUSTERED
	(
		MaThongKe
	) ON [Primary]
GO
--- 8. Tạo khóa chính bảng Phương thức thanh toán
ALTER TABLE PhuongThucThanhToan with nocheck ADD
	constraint PK_PhuongThucThanhToan PRIMARY KEY CLUSTERED
	(
		MaPhuongThuc
	) ON [Primary]
GO
--- 9. Tạo khóa chính bảng Đơn giá phòng
ALTER TABLE DonGiaPhong with nocheck ADD
	constraint PK_DonGiaPhong PRIMARY KEY CLUSTERED
	(
		MaPhong,
		MaLoai
	) ON [Primary]
GO
--- 10. Tạo khóa chính bảng Khách hàng
ALTER TABLE KhachHang with nocheck ADD
	constraint PK_KhachHang PRIMARY KEY CLUSTERED
	(
		MaKH
	) ON [Primary]
GO
--- 11. Tạo khóa chính bảng Nhân viên
ALTER TABLE NhanVien with nocheck ADD
	constraint PK_NhanVien PRIMARY KEY CLUSTERED
	(
		MaNV
	) ON [Primary]
GO
--- 12. Tạo khóa chính bảng Checkin_Checkout
ALTER TABLE CheckInOut with nocheck ADD
	constraint PK_CheckInOut PRIMARY KEY CLUSTERED
	(
		MaDatPhong
	) ON [Primary]
GO
--- 13. Tạo khóa chính bảng Đặt dịch vụ
ALTER TABLE DatDichVu with nocheck ADD
	constraint PK_DatDichVu PRIMARY KEY CLUSTERED
	(
		MaPhong,
		MaDichVu
	) ON [Primary]
GO
--- 14. Tạo khóa chính bảng Đặt tiện ích Resort
ALTER TABLE DatTienIchResort with nocheck ADD
	constraint PK_DatTienIchResort PRIMARY KEY CLUSTERED
	(
		MaPhong,
		MaTienIch
	) ON [Primary]
GO
--- 15. Tạo khóa chính bảng Đặt phòng
ALTER TABLE DatPhong with nocheck ADD
	constraint PK_DatPhong PRIMARY KEY CLUSTERED
	(
		MaDatPhong
	) ON [Primary]
GO
--- 16. Tạo khóa chính bảng Phiếu xác nhận đặt phòng
ALTER TABLE PhieuXacNhanDatPhong with nocheck ADD
	constraint PK_PhieuXacNhanDatPhong PRIMARY KEY CLUSTERED
	(
		MaPhieuXacNhan
	) ON [Primary]
GO
--- 17. Tạo khóa chính bảng Phòng
ALTER TABLE Phong with nocheck ADD
	constraint PK_Phong PRIMARY KEY CLUSTERED
	(
		MaPhong
	) ON [Primary]
GO
-------------------------------------------------------------------
-------------------------------------------------------------------
--- Tạo khóa ngoại
--- 1. Tạo khóa ngoại bảng Phòng
ALTER TABLE Phong ADD
CONSTRAINT FK_Phong_LoaiPhong FOREIGN KEY
	(
		MaLoai
	) REFERENCES LoaiPhong(MaLoai)
GO
--- 2. Tạo khóa ngoại bảng Đặt phòng
ALTER TABLE DatPhong ADD 
	CONSTRAINT FK_DatPhong_Phong FOREIGN KEY 
	(
		MaPhong
	) REFERENCES Phong (
		MaPhong
	),
	CONSTRAINT FK_DatPhong_PhuongThucThanhToan FOREIGN KEY 
	(
		MaPhuongThuc
	) REFERENCES PhuongThucThanhToan (
		MaPhuongThuc
	),
	CONSTRAINT FK_DatPhong_PhieuXacNhanDatPhong FOREIGN KEY 
	(
		MaPhieuXacNhan
	) REFERENCES PhieuXacNhanDatPhong (
		MaPhieuXacNhan
	)
GO
--- 3. Tạo khóa ngoại bảng Đặt tiện ích resort
ALTER TABLE DatTienIchResort ADD
	CONSTRAINT FK_DatTienIchResort_Phong FOREIGN KEY 
	(
		MaPhong
	) REFERENCES Phong (
		MaPhong
	),
	CONSTRAINT FK_DatTienIchResort_TienIchResort FOREIGN KEY 
	(
		MaTienIch
	) REFERENCES TienIchResort(
		MaTienIch
	)
GO
--- 4. Tạo khóa ngoại bảng Đặt dịch vụ
ALTER TABLE DatDichVu ADD
	CONSTRAINT FK_DatDichVu_Phong FOREIGN KEY 
	(
		MaPhoNG
	) REFERENCES Phong (
		MaPhong
	),
	CONSTRAINT FK_DatDichVu_DichVu FOREIGN KEY 
	(
		MaDichVu
	) REFERENCES DichVu(
		MaDichVu
	)
GO
--- 5. Tạo khóa ngoại bảng Phiếu xác nhận đặt phòng
ALTER TABLE PhieuXacNhanDatPhong ADD
	CONSTRAINT FK_PhieuXacNhanDatPhong_DatPhong FOREIGN KEY 
	(
		MaDatPhong
	) REFERENCES DatPhong (
		MaDatPhong
	),
	CONSTRAINT FK_PhieuXacNhanDatPhong_PhuongThucThanhToan FOREIGN KEY 
	(
		MaPhuongThuc
	) REFERENCES PhuongThucThanhToan(
		MaPhuongThuc
	)
GO
--- 6. Tạo khóa ngoại bảng Checkin-checkout
ALTER TABLE CheckInOut ADD
	CONSTRAINT FK_CheckInOut_DatPhong FOREIGN KEY 
	(
		MaDatPhong
	) REFERENCES DatPhong (
		MaDatPhong
	),
	CONSTRAINT FK_CheckInOut_NhanVien FOREIGN KEY 
	(
		MaNV
	) REFERENCES NhanVien(
		MaNV
	)
GO
--- 7. Tạo khóa ngoại bảng Khách hàng
ALTER TABLE KhachHang ADD
CONSTRAINT FK_KhachHang_TaiKhoan FOREIGN KEY
	(
		MaTaiKhoan
	) REFERENCES TaiKhoan(MaTaiKhoan)
GO
--- 8. Tạo khóa ngoại bảng Tài khoản
ALTER TABLE TaiKhoan ADD 
	CONSTRAINT FK_TaiKhoan_KhachHang FOREIGN KEY 
	(
		MaKH
	) REFERENCES KhachHang (
		MaKH
	),
	CONSTRAINT FK_TaiKhoan_NhanVien FOREIGN KEY 
	(
		MaNV
	) REFERENCES NhanVien (
		MaNV
	),
	CONSTRAINT FK_TaiKhoan_PhanQuyen FOREIGN KEY 
	(
		MaPQ
	) REFERENCES PhanQuyen (
		MaPQ
	)
GO
--- 9. Tạo khóa ngoại bảng Nhân viên
ALTER TABLE NhanVien ADD
	CONSTRAINT FK_NhanVien_TaiKhoan FOREIGN KEY 
	(
		MaTaiKhoan
	) REFERENCES TaiKhoan (
		MaTaiKhoan
	),
	CONSTRAINT FK_NhanVien_ChucVu FOREIGN KEY 
	(
		MaChucVu
	) REFERENCES ChucVu(
		MaChucVu
	)
GO
--- 10. Tạo khóa ngoại bảng Thống kê doanh thu
ALTER TABLE ThongKeDoanhThu ADD
CONSTRAINT FK_ThongKeDoanhThu_NhanVien FOREIGN KEY
	(
		MaNV
	) REFERENCES NhanVien(MaNV)
GO
--- 11. Tạo khóa ngoại bảng Đơn giá phòng
ALTER TABLE DonGiaPhong ADD
	CONSTRAINT FK_DonGiaPhong_Phong FOREIGN KEY 
	(
		MaPhong
	) REFERENCES Phong (
		MaPhong
	),
	CONSTRAINT FK_DonGiaPhong_LoaiPhong FOREIGN KEY 
	(
		MaLoai
	) REFERENCES LoaiPhong(
		MaLoai
	)
GO
-----------------------------------------------
-------- Tạo các ràng buộc --------------------
--- 1. Tạo ràng buộc bảng Khách hàng: số CMND chỉ là duy nhất
ALTER TABLE KhachHang ADD CONSTRAINT UC_KhachHang UNIQUE (SoCMND);
--- 2. Tạo ràng buộc bảng Tài khoản: username chỉ là duy nhất
Alter table TaiKhoan add constraint UC_TaiKhoan UNIQUE (Username);
--- 3. Tạo ràng buộc bảng Đặt dịch vụ: số lượng phải lớn hơn 0
ALTER TABLE DatDichVu ADD CONSTRAINT CHK_DatDichVu CHECK (SoLuong>0);
--- 4. Tạo ràng buộc bảng Đơn giá phòng: đơn giá phải lớn hơn 0
ALTER TABLE DonGiaPhong ADD CONSTRAINT CHK_DonGiaPhong CHECK (DonGia>0);
--- 5. Tạo ràng buộc bảng Phòng: đơn giá phải lớn hơn 0
ALTER TABLE Phong ADD CONSTRAINT CHK_Phong CHECK (DonGia>0);
-----------------------------------------------
-------- Nhập dữ liệu -------------------------
-----------------------------------------------------------------------------
----------------- Dương Thị Tuyết Như _ 19DH110140 -----------------------------------------------------------------
-- Khách Hàng --
Insert into KhachHang (HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Dương Thị Tuyết Như', N'Nữ', '017652381211', '0932178128', 'VietNam', '2001-10-21', null);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Vũ Phương An', N'Nữ', '033255476541', '0908523528', 'VietNam', '2001-06-05', NULL);
Insert into KhachHang (HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Huỳnh Duy Khang', N'Nam', '079324134265', '0932873285', 'VietNam', '2001-03-31', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Trần Quốc Tú', N'Nam', '072429812462', '0931923743', 'VietNam', '2001-10-21', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Nguyễn Văn Đạt', N'Nam', '021847232762', '0908992341', 'VietNam', '2000-06-30', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Nguyễn Duy Khang', N'Nam', '092173128774', '0932875649', 'VietNam', '2001-08-22', NULL);
Insert into KhachHang (HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Đỗ Tuấn Khải', N'Nam', '098327451212', '0931354646', 'VietNam', '2004-02-19', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Nguyễn Gia Hân', N'Nữ', '081824612177', '0938176421', 'VietNam', '2005-10-27', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Phan Minh Hoàng', N'Nam', '041714612124', '0931246734', 'VietNam', '2005-03-03', NULL);
Insert into KhachHang (HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Trần Quốc Vinh', N'Nam', '081727612197', '0923521123', 'VietNam', '1998-10-27', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Lê Trương Thảo Uyên', N'Nữ', '014579741211', '0931246768', 'ThaiLand', '2001-01-01', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Nguyễn Dương Giang ', N'Nam', '081727612129', '0932124728', 'VietNam', '2001-11-17', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Phạm Đức Thiện', N'Nam', '045624612124', '0932781761', 'VietNam', '1998-08-28', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Nguyễn Thị Hồng Mỹ', N'Nữ', '073562723246', '0932176498', 'VietNam', '2001-02-14', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Nguyễn Xuân Hiệp', N'Nam', '081724614224', '0938176421', 'VietNam', '2000-08-30', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Nguyễn Thị Kim Ngân', N'Nữ', '073282323247', '0942452385', 'VietNam', '2001-12-25', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Phan Thị Trà My', N'Nữ', '073562323286', '0932346347', 'VietNam', '1999-02-14', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Dương Tuấn Anh', N'Nam', '077242323246', '0931235436', 'VietNam', '1992-02-14', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Nguyễn Thị Thu Trang', N'Nữ', '073565329249', '093226523', 'VietNam', '2001-12-24', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Dương Tấn Lực', N'Nam', '082317176572', '0909841264', 'VietNam', '1994-07-14', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Phạm Ngọc Như Ý', N'Nữ', '073236263728', '0985834237', 'VietNam', '1995-01-22', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Nguyễn Hoàng Thắng', N'Nam', '017222353578', '0702629240', 'VietNam', '1999-12-14', NULL);
Insert into KhachHang (HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values (N'Dương Hoài An', N'Nữ', '013521245655', '0924857644', 'VietNam', '2001-12-24', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Nguyễn Thị Hồng Nhung', N'Nữ', '034626542765', '0725844582', 'VietNam', '2001-09-21', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Lâm Chánh Huy', N'Nam', '035645765715', '0735646957', 'VietNam', '2000-08-01', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Trương Thị Thanh Tuyền', N'Nữ', '076545635897', '0264484866', 'VietNam', '2001-10-28', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Huỳnh Hồ Bảo Nhi', N'Nữ', '035848912926', '0936165812', 'VietNam', '2001-12-06', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Huỳnh Thị Tuyết Loan', N'Nữ', '076465192515', '0932467974', 'VietNam', '2001-12-30', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Tân Việt Duy Long', N'Nam', '036453795767', '0932467576', 'VietNam', '2003-06-17', NULL);
Insert into KhachHang ( HoTen, GioiTinh, SoCMND, SDT, QuocTich, NgaySinh, MaTaiKhoan) values ( N'Dương Tuấn Anh', N'Nam', '034679819285', '0932466725', 'VietNam', '1994-07-14', NULL);
-- Loại Phòng --
Insert into LoaiPhong (MaLoai, TenLoai, ChiTiet) values (11, N'Phòng gia đình cao cấp','rộng 117m2, Ban công đôi có bàn ghế, Hành lang phía trước, Tủ âm tường, Khu vực tiếp khách với hai giường sofa, Ngõ với ghế dài, 2 Giường đơn, 2 Giường cỡ King, Bồn rửa trang điểm đôi, Bàn trang điểm rộng, Bồn ngâm chân đế dành cho hai người, TV 65"');
Insert into LoaiPhong (MaLoai, TenLoai, ChiTiet) values (22, N'Superior 2 giường đơn', 'rộng 45m2, Bồn rửa vệ sinh đôi, nhà vệ sinh riêng biệt, phòng tắm vòi sen độc lập, 2 Giường đơn, Máy sấy tóc, Gương lúp, TV 55" ');

Insert into LoaiPhong (MaLoai, TenLoai, ChiTiet) values (33, N'Superior giường đôi', 'rộng 45m2, Ban công riêng với bàn ghế, Giường sofa và ghế bành, 1 Giường cỡ King, C.O. Đồ vệ sinh cá nhân Bigelow®, Ấm đun nước và máy pha cà phê, TV 55" ');

Insert into LoaiPhong (MaLoai, TenLoai, ChiTiet) values (44, N'Deluxe 2 giường đơn view biển', 'rộng 45m2, ban công riêng với bàn ghế, Giường sofa và ghế bành, 2 Giường đơn, Hệ thống bồn vệ sinh tự động thông minh Nhật Bản, Bồn rửa trang điểm đôi, Ấm đun nước và máy pha cà phê, TV 55" ');

Insert into LoaiPhong (MaLoai, TenLoai, ChiTiet) values (55, N'Premium Deluxe giường đôi view biển', 'rộng 45m2, Ban công riêng với bàn ghế, Giường sofa và ghế bành, 1 Giường cỡ King, Vòi sen tắm đứng và bồn tắm, Ấm đun nước và máy pha cà phê, TV 55" ');

Insert into LoaiPhong (MaLoai, TenLoai, ChiTiet) values (66, N'Biệt thự biển', 'rộng 300m2, hồ bơi riêng và sân vườn, hai phòng ngủ với giường cỡ King, Bồn rửa trang điểm đôi, Ấm đun nước và máy pha cà phê espresso, Bếp nhỏ, Bàn ăn cho 10 người, TV 65" ' );
-- Phòng -- 
---// Tầng 1
Insert into Phong (MaPhong, MaLoai,SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (101,11 ,3,'' , 10000000.00, N'Thoải mái và đầy phong cách, Phòng Gia đình Cao cấp của chúng tôi là một lựa chọn cho các nhóm hoặc gia đình đông người. Trong căn phòng chính có thêm bồn ngâm độc lập, khu vực tiếp khách, góc đọc sách và hai ghế sofa; căn phòng còn lại được trang bị đầy đủ tiện nghi để mang đến một kỳ nghỉ thư giãn cho tất cả mọi người.', 0);
Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (102, 22, 2,'' , 3500000.00, N'phòng Superior với 2 giường đơn có kích thước hoàn hảo cho hai người.', 0);

Insert into Phong (MaPhong,MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (103, 33, 1, '' , 3800000.00, N'Căn phòng Superior này rộng 45m2 là không gian hiệu suất cao dành cho những du khách đi một mình, các cặp đôi hoặc một gia đình nhỏ', 0);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (104, 44, 2, '' , 5000000.00, N'Chiêm ngưỡng toàn cảnh biển trời chuyển sắc từ ban công của căn phòng trên tầng cao. Phòng Deluxe 2 giường đơn hướng vườn sẽ mang đến cho du khách khung cảnh của hồ bơi, bãi biển và xa hơn nữa là nước biển xanh ngọc', 1);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (105, 55, 1, '' , 6000000.00, N' Cảnh sắc của bờ biển và đại dương sẽ ở ngay bên ngoài cửa trượt ban công. Phòng Premium Deluxe Giường đôi Hướng biển là tổ ấm tinh tế cho những ai tìm kiếm tiện nghi cao cấp và tầm nhìn thượng lưu', 1);

--//Tầng 2
Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (201,11, 3, '' , 10000000.00, N'Thoải mái và đầy phong cách, Phòng Gia đình Cao cấp của chúng tôi là một lựa chọn cho các nhóm hoặc gia đình đông người. Trong căn phòng chính có thêm bồn ngâm độc lập, khu vực tiếp khách, góc đọc sách và hai ghế sofa; căn phòng còn lại được trang bị đầy đủ tiện nghi để mang đến một kỳ nghỉ thư giãn cho tất cả mọi người.', 1);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (202, 22, 2, '' , 3500000.00, N'phòng Superior với 2 giường đơn có kích thước hoàn hảo cho hai người.', 0);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (203, 33, 1,''  , 3800000.00, N'Căn phòng Superior này rộng 45m2 là không gian hiệu suất cao dành cho những du khách đi một mình, các cặp đôi hoặc một gia đình nhỏ', 0);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (204, 44, 2, '' , 5000000.00, N'Chiêm ngưỡng toàn cảnh biển trời chuyển sắc từ ban công của căn phòng trên tầng cao. Phòng Deluxe 2 giường đơn hướng vườn sẽ mang đến cho du khách khung cảnh của hồ bơi, bãi biển và xa hơn nữa là nước biển xanh ngọc', 0);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (205, 55, 1,''  , 6000000.00, N' Cảnh sắc của bờ biển và đại dương sẽ ở ngay bên ngoài cửa trượt ban công. Phòng Premium Deluxe Giường đôi Hướng biển là tổ ấm tinh tế cho những ai tìm kiếm tiện nghi cao cấp và tầm nhìn thượng lưu', 1);

--//Tầng 3
Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (301, 11, 3,''  , 10000000.00, N'Thoải mái và đầy phong cách, Phòng Gia đình Cao cấp của chúng tôi là một lựa chọn cho các nhóm hoặc gia đình đông người. Trong căn phòng chính có thêm bồn ngâm độc lập, khu vực tiếp khách, góc đọc sách và hai ghế sofa; căn phòng còn lại được trang bị đầy đủ tiện nghi để mang đến một kỳ nghỉ thư giãn cho tất cả mọi người.', 1);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (302,22, 2,''  , 3500000.00, N'phòng Superior với 2 giường đơn có kích thước hoàn hảo cho hai người.', 0);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (303, 33, 1,''  , 3800000.00, N'Căn phòng Superior này rộng 45m2 là không gian hiệu suất cao dành cho những du khách đi một mình, các cặp đôi hoặc một gia đình nhỏ', 1);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (304, 44, 2,''  , 5000000.00, N'Chiêm ngưỡng toàn cảnh biển trời chuyển sắc từ ban công của căn phòng trên tầng cao. Phòng Deluxe 2 giường đơn hướng vườn sẽ mang đến cho du khách khung cảnh của hồ bơi, bãi biển và xa hơn nữa là nước biển xanh ngọc', 0);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (305, 55, 1, '' , 6000000.00, N' Cảnh sắc của bờ biển và đại dương sẽ ở ngay bên ngoài cửa trượt ban công. Phòng Premium Deluxe Giường đôi Hướng biển là tổ ấm tinh tế cho những ai tìm kiếm tiện nghi cao cấp và tầm nhìn thượng lưu', 1);

--//Tầng 4
Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (401, 11, 3, '' , 10000000.00, N'Thoải mái và đầy phong cách, Phòng Gia đình Cao cấp của chúng tôi là một lựa chọn cho các nhóm hoặc gia đình đông người. Trong căn phòng chính có thêm bồn ngâm độc lập, khu vực tiếp khách, góc đọc sách và hai ghế sofa; căn phòng còn lại được trang bị đầy đủ tiện nghi để mang đến một kỳ nghỉ thư giãn cho tất cả mọi người.', 0);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (402, 22, 2, '' , 3500000.00, N'phòng Superior với 2 giường đơn có kích thước hoàn hảo cho hai người.', 0);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (403, 33, 1,''  , 3800000.00, N'Căn phòng Superior này rộng 45m2 là không gian hiệu suất cao dành cho những du khách đi một mình, các cặp đôi hoặc một gia đình nhỏ', 1);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (404, 44, 2,''  , 5000000.00, N'Chiêm ngưỡng toàn cảnh biển trời chuyển sắc từ ban công của căn phòng trên tầng cao. Phòng Deluxe 2 giường đơn hướng vườn sẽ mang đến cho du khách khung cảnh của hồ bơi, bãi biển và xa hơn nữa là nước biển xanh ngọc', 1);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (405, 55, 1,''  , 6000000.00, N' Cảnh sắc của bờ biển và đại dương sẽ ở ngay bên ngoài cửa trượt ban công. Phòng Premium Deluxe Giường đôi Hướng biển là tổ ấm tinh tế cho những ai tìm kiếm tiện nghi cao cấp và tầm nhìn thượng lưu', 0);

--//Tầng 5
Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (501, 11, 3,''  , 10000000.00, N'Thoải mái và đầy phong cách, Phòng Gia đình Cao cấp của chúng tôi là một lựa chọn cho các nhóm hoặc gia đình đông người. Trong căn phòng chính có thêm bồn ngâm độc lập, khu vực tiếp khách, góc đọc sách và hai ghế sofa; căn phòng còn lại được trang bị đầy đủ tiện nghi để mang đến một kỳ nghỉ thư giãn cho tất cả mọi người.', 1);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (502, 22, 2,''  , 3500000.00, N'phòng Superior với 2 giường đơn có kích thước hoàn hảo cho hai người.', 1);

Insert into Phong (MaPhong,MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (503, 33, 1, '' , 3800000.00, N'Căn phòng Superior này rộng 45m2 là không gian hiệu suất cao dành cho những du khách đi một mình, các cặp đôi hoặc một gia đình nhỏ', 1);

Insert into Phong (MaPhong,MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (504, 44, 2, '' , 5000000.00, N'Chiêm ngưỡng toàn cảnh biển trời chuyển sắc từ ban công của căn phòng trên tầng cao. Phòng Deluxe 2 giường đơn hướng vườn sẽ mang đến cho du khách khung cảnh của hồ bơi, bãi biển và xa hơn nữa là nước biển xanh ngọc', 1);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (505, 55, 1,''  , 6000000.00, N' Cảnh sắc của bờ biển và đại dương sẽ ở ngay bên ngoài cửa trượt ban công. Phòng Premium Deluxe Giường đôi Hướng biển là tổ ấm tinh tế cho những ai tìm kiếm tiện nghi cao cấp và tầm nhìn thượng lưu', 1);

---// Biệt thự biển
Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (601, 66, 4, '' , 15000000.00, N'Một không gian riêng tư cho cả gia đình. Tính linh hoạt liền mạch cho mọi người giải tỏa mọi căng thẳng. Không gian mở để phục hồi năng lượng tích cực hoặc cởi mở tâm trí', 0);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (602,66, 4, '' , 15000000.00, N'Một không gian riêng tư cho cả gia đình. Tính linh hoạt liền mạch cho mọi người giải tỏa mọi căng thẳng. Không gian mở để phục hồi năng lượng tích cực hoặc cởi mở tâm trí', 1);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (603, 66, 4, '' , 15000000.00, N'Một không gian riêng tư cho cả gia đình. Tính linh hoạt liền mạch cho mọi người giải tỏa mọi căng thẳng. Không gian mở để phục hồi năng lượng tích cực hoặc cởi mở tâm trí', 1);

Insert into Phong (MaPhong, MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (604,66, 4, '' , 15000000.00, N'Một không gian riêng tư cho cả gia đình. Tính linh hoạt liền mạch cho mọi người giải tỏa mọi căng thẳng. Không gian mở để phục hồi năng lượng tích cực hoặc cởi mở tâm trí', 0);

Insert into Phong (MaPhong,MaLoai, SoGiuong, HinhAnh, DonGia, MoTaThongTin, TrangThai) values (605, 66, 4, '' , 15000000.00, N'Một không gian riêng tư cho cả gia đình. Tính linh hoạt liền mạch cho mọi người giải tỏa mọi căng thẳng. Không gian mở để phục hồi năng lượng tích cực hoặc cởi mở tâm trí', 0);
-- Phương thức thanh toán --
Insert into PhuongThucThanhToan (TenPhuongThuc) values (N'Thanh toán tiền mặt');
Insert into PhuongThucThanhToan ( TenPhuongThuc) values ( N'Thẻ tín dụng, ghi nợ');
Insert into PhuongThucThanhToan ( TenPhuongThuc) values ( N'Ví Momo');
Insert into PhuongThucThanhToan (TenPhuongThuc) values ( N'Ví ZaloPay');
Insert into PhuongThucThanhToan (TenPhuongThuc) values ( N'VNPAY');
-- Đơn giá Phòng --
Insert into DonGiaPhong (MaPhong, MaLoai, DonGia) values (101, 11, 10000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (201, 11, 10000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (301,11, 10000000.00);
Insert into DonGiaPhong (MaPhong, MaLoai, DonGia) values (401, 11, 10000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (501, 11, 10000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (102, 22, 3500000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (202, 22, 3500000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (302, 22, 3500000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (402, 22, 3500000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (502, 22, 3500000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (103,33, 3800000.00);
Insert into DonGiaPhong (MaPhong, MaLoai, DonGia) values (203, 33, 3800000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (303,33, 3800000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (403, 33, 3800000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (503, 33, 3800000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (104, 44, 5000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (204, 44, 5000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (304, 44, 5000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (404, 44, 5000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (504, 44, 5000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (105, 55, 6000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (205, 55, 6000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (305, 55, 6000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (405, 55, 6000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (505, 55, 6000000.00);

Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (601, 66, 15000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (602,66, 15000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (603, 66, 15000000.00);
Insert into DonGiaPhong (MaPhong, MaLoai, DonGia) values (604, 66, 15000000.00);
Insert into DonGiaPhong (MaPhong,  MaLoai, DonGia) values (605, 6, 15000000.00);
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------
----------------- Vũ Phương An _ 19DH110766 -----------------------------------------------------------------
----- Phân quyền--------------------------------------------------------------------
insert into PhanQuyen(TenPQ) values (N'Admin');
insert into PhanQuyen(TenPQ) values (N'Khách Hàng');
insert into PhanQuyen(TenPQ) values (N'Nhân Viên');
----- Chức vụ -----------------------------------------------------------------------
insert into ChucVu(TenChucVu) values (N'Nhân Viên Phòng');
insert into ChucVu(TenChucVu) values (N'Quản lý');
------ Tài khoản --------------------------------------------------------------------
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'admin', N'123456', 1, null, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'quanly', N'123456', 3, null, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'nvphong', N'123456', 3, null, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'dnhuu', N'dnhu123', 2, 1, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'anu', N'anu201019', 2, 2, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'khanghuynh', N'SimonK310301', 2, 3, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'quoctutran', N'quoctutran050601', 2, 4, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'datnguyen', N'DatNguyen300600', 2, 5, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'khangnguyen', N'xike2208', 2, 6, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'tuankhai', N'khaido1902', 2, 7, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'hannguyen', N'hannie2710', 2, 8, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'phanhoang', N'phanhoang030305', 2, 9, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'quocvinh', N'quocvinh2710', 2, 10, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'thaouyen', N'thaouyen0101', 2, 11, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'giangnguyen', N'giangnguyen', 2, 12, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'phamthien', N'phamthien0828', 2, 13, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'vian', N'vian040201', 2, 14, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'nguyenhiep', N'nguyenhiep3008', 2, 15, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'kimngan', N'kimngannguyen2512', 2, 16, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'tramy', N'tramy1402', 2, 17, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'duonganh', N'dta140299', 2, 18, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'thutrang', N'nttt2412', 2, 19, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'tanluc', N'tanluc0714', 2, 20, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'nhuypham', N'nhuypham95', 2, 21, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'thangnguyen95', N'thangnguyen1214', 2, 22, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'hoaian', N'hoaianduong2412', 2, 23, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'hongnhung', N'nthn2109', 2, 24, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'huylam', N'lch0108', 2, 25, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'tuyentruong', N'2t2t2810', 2,26, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'nhihuynh', N'2hbnhi0612', 2, 27, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'tuyetloanhuynh', N'httl1230', 2, 28, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'duylong', N'tvdl1706', 2, 29, null);
insert into TaiKhoan(UserName, Passwordd, MaPQ, MaKH, MaNV) values (N'tuananhduong', N'dta140794', 2, 30, null);
----------------------------------------------------------------------------------------------------------------
------ Đặt phòng -----------------------------------------------------------------------
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (101,1, null, N'Dương Thị Tuyết Như', '2022-03-30', '2022-04-05', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (102,3,  null, N'Vũ Phương An', '2022-03-30', '2022-04-01', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (103,1,  null, N'Huỳnh Duy Khang', '2022-03-30', '2022-03-31', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (104,1,  null, N'Trần Quốc Tú', '2022-03-31', '2022-04-02', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (105,4,  null, N'Nguyễn Văn Đạt', '2022-03-30', '2022-03-31', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (201,1,  null, N'Nguyễn Duy Khang', '2022-03-30', '2022-04-04', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (202,2,  null, N'Đỗ Tuấn Khải', '2022-03-30', '2022-03-31', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (203,1,  null, N'Nguyễn Gia Hân', '2022-03-31', '2022-04-03', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (204,2,  null, N'Phan Minh Hoàng', '2022-04-01', '2022-04-02', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (205,1,  null, N'Trần Quốc Vinh', '2022-03-30', '2022-04-02', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (301,4,  null, N'Lê Trương Thảo Uyên', '2022-04-02', '2022-04-06', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (302,1,  null, N'Nguyễn Dương Giang', '2022-04-02', '2022-04-06', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (303,2,  null, N'Phạm Đức Thiện', '2022-04-02', '2022-04-07', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (304,1,  null, N'Nguyễn Thị Hồng Mỹ', '2022-04-02', '2022-04-06', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (305,1,  null, N'Nguyễn Xuân Hiệp', '2022-04-01', '2022-04-05', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (401,3,  null, N'Nguyễn Thị Kim Ngân', '2022-04-01', '2022-04-03', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (402,3,  null, N'Phan Thị Trà My', '2022-04-01', '2022-04-03', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (403,3,  null, N'Dương Tuấn Anh', '2022-04-01', '2022-04-02', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (404,1,  null, N'Nguyễn Thị Thu Trang', '2022-04-04', '2022-04-07', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (405,4,  null, N'Dương Tấn Lực', '2022-04-03', '2022-04-04', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (501,1,  null, N'Phạm Ngọc Như Ý', '2022-04-02', '2022-04-03', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (502,1,  null, N'Nguyễn Hoàng Thắng', '2022-04-02', '2022-04-04', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (503,1,  null, N'Dương Hoài An', '2022-04-05', '2022-04-09', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (504,2,  null, N'Nguyễn Thị Hồng Nhung', '2022-04-05', '2022-04-09', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (505,1,  null, N'Lâm Chánh Huy', '2022-04-05', '2022-04-10', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (601,1,  null, N'Trương Thị Thanh Tuyền', '2022-04-05', '2022-04-10', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (602,1,  null, N'Huỳnh Hồ Bảo Nhi', '2022-04-05', '2022-04-09', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (603,1,  null, N'Huỳnh Thị Tuyết Loan', '2022-04-06', '2022-04-11', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (604,1,  null, N'Tân Việt Duy Long', '2022-04-06', '2022-04-09', null );
insert into DatPhong (MaPhong, MaPhuongThuc, MaPhieuXacNhan, TenKH, NgayDatPhong, NgayTraPhong, YeuCauThem) values (605,1,  null, N'Dương Tuấn Anh', '2022-04-07', '2022-04-15', null );
------ Phiếu xác nhận đặt phòng --------------------------------------------------------
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (1, N'Dương Thị Tuyết Như', null, '10000000', '2022-03-30', '2022-04-05', N'Thành công', 1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (2, N'Vũ Phương An', null, '3500000', '2022-03-30', '2022-04-01', N'Thành công', 3);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (3, N'Huỳnh Duy Khang', null, '3800000', '2022-03-30', '2022-04-01', N'Thành công', 1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (4, N'Trần Quốc Tú', null, '5000000', '2022-03-31', '2022-04-02', N'Thành công', 1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (5, N'Nguyễn Văn Đạt', null, '6000000', '2022-03-30', '2022-03-31', N'Thành công', 4);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (6, N'Nguyễn Duy Khang', null, '10000000', '2022-03-30', '2022-04-04', N'Thành công', 1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (7, N'Đỗ Tuấn Khải', null, '3500000', '2022-03-30', '2022-03-31', N'Thành công', 2);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (8, N'Nguyễn Gia Hân', null, '3800000', '2022-03-31', '2022-04-03', N'Thành công', 1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (9, N'Phan Minh Hoàng', null, '5000000', '2022-04-01', '2022-04-02', N'Thành công', 2);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (10, N'Trần Quốc Vinh', null, '6000000', '2022-03-30', '2022-04-02', N'Thành công', 1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (11, N'Lê Trương Thảo Uyên', null, '10000000', '2022-04-02', '2022-04-06', N'Thành công',4);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (12, N'Nguyễn Dương Giang', null, '3500000', '2022-04-02', '2022-04-06', N'Thành công',1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (13, N'Phạm Đức Thiện', null, '3800000','2022-04-02', '2022-04-07', N'Thành công',2);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (14, N'Nguyễn Thị Hồng Mỹ', null, '5000000','2022-04-02', '2022-04-06', N'Thành công',1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (15, N'Nguyễn Xuân Hiệp', null,'6000000','2022-04-01', '2022-04-05', N'Thành công',1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (16, N'Nguyễn Thị Kim Ngân', null,'10000000','2022-04-01', '2022-04-03', N'Thành công',3);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (17, N'Phan Thị Trà My', null,'3500000','2022-04-01', '2022-04-03', N'Thành công',3);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (18, N'Dương Tuấn Anh', null,'3800000','2022-04-01', '2022-04-02', N'Thành công',3);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (19, N'Nguyễn Thị Thu Trang', null,'5000000','2022-04-04', '2022-04-07', N'Thành công',1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (20, N'Dương Tấn Lực', null,'6000000','2022-04-03', '2022-04-04', N'Thành công',4);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (21, N'Phạm Ngọc Như Ý', null,'10000000','2022-04-02', '2022-04-03', N'Thành công',1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (22, N'Nguyễn Hoàng Thắng', null,'3500000','2022-04-02', '2022-04-04', N'Thành công',1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (23, N'Dương Hoài An', null,'3800000','2022-04-05', '2022-04-09', N'Thành công',1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (24, N'Nguyễn Thị Hồng Nhung', null,'5000000','2022-04-05', '2022-04-09', N'Thành công',2);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (25, N'Lâm Chánh Huy', null,'6000000','2022-04-05', '2022-04-10', N'Thành công',1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (26, N'Trương Thị Thanh Tuyền', null,'10000000','2022-04-05', '2022-04-10', N'Thành công',1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (27, N'Huỳnh Hồ Bảo Nhi', null,'3500000','2022-04-05', '2022-04-09', N'Thành công',1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (28, N'Huỳnh Thị Tuyết Loan', null,'3800000','2022-04-06', '2022-04-11', N'Thành công',1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (29, N'Tân Việt Duy Long', null,'5000000','2022-04-06', '2022-04-09', N'Thành công',1);
insert into PhieuXacNhanDatPhong (MaDatPhong, TenKH, YeuCauThem, DonGia, NgayDatPhong, NgayTraPhong, TrangThaiDatPhong, MaPhuongThuc) values (30, N'Dương Tuấn Anh', null,'6000000','2022-04-07', '2022-04-15', N'Thành công',1);
------ Nhân viên -----------------------------------------------------------------------
insert into NhanVien(HoTen, GioiTinh, NgaySinh, DiaChi, MaChucVu, MaTaiKhoan) values (N'Vũ Phương An', N'Nữ', '2001-09-06', N'52 Nguyễn Thái Bình', 2, null);
insert into NhanVien(HoTen, GioiTinh, NgaySinh, DiaChi, MaChucVu, MaTaiKhoan) values (N'An Vũ', N'Nữ', '2001-09-06', N'22 Đường số 21', 1, null);
insert into NhanVien(HoTen, GioiTinh, NgaySinh, DiaChi, MaChucVu, MaTaiKhoan) values (N'Dương Thị Tuyết Như', N'Nữ', '2001-10-21', N'666 Lê Trọng Tấn', 2, null);
insert into NhanVien(HoTen, GioiTinh, NgaySinh, DiaChi, MaChucVu, MaTaiKhoan) values (N'Dương Như', N'Nữ', '2001-10-21', N'34 Chế Lan Viên', 1, null);
insert into NhanVien(HoTen, GioiTinh, NgaySinh, DiaChi, MaChucVu, MaTaiKhoan) values (N'Lê Trương Thảo Uyên', N'Nữ', '2001-01-01', N'82 Hòa Hưng', 2, null);
insert into NhanVien(HoTen, GioiTinh, NgaySinh, DiaChi, MaChucVu, MaTaiKhoan) values (N'Lê Thảo Uyên', N'Nữ', '2001-01-01', N'82 CMT8', 1, null);
insert into NhanVien(HoTen, GioiTinh, NgaySinh, DiaChi, MaChucVu, MaTaiKhoan) values (N'Trần Quốc Tú', N'Nam', '2001-06-05', N'29 Âu Dương Lân', 1, null);
insert into NhanVien(HoTen, GioiTinh, NgaySinh, DiaChi, MaChucVu, MaTaiKhoan) values (N'Nguyễn Thị Hồng Mỹ', N'Nữ', '2001-02-04', N'12 Nguyễn Thị Tần', 1, null);
insert into NhanVien(HoTen, GioiTinh, NgaySinh, DiaChi, MaChucVu, MaTaiKhoan) values (N'Huỳnh Duy Khang', N'Nam', '2001-03-31', N'179 Nguyễn Văn Lượng', 1, null);
insert into NhanVien(HoTen, GioiTinh, NgaySinh, DiaChi, MaChucVu, MaTaiKhoan) values (N'Nguyễn Duy Khang', N'Nam', '2001-02-18', N'156 Nguyễn Văn Khối', 1, null);
------ CheckInOut ----------------------------------------------------------------------
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (1, N'Dương Thị Tuyết Như','2022-03-30', '2022-04-05',null, 0, 1);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (2, N'Vũ Phương An','2022-03-30', '2022-04-01',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (3,N'Huỳnh Duy Khang', '2022-03-30', '2022-03-31',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (4, N'Trần Quốc Tú', '2022-03-31', '2022-04-02',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (5, N'Nguyễn Văn Đạt', '2022-03-30', '2022-03-31',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (6, N'Nguyễn Duy Khang', '2022-03-30', '2022-04-04',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (7, N'Đỗ Tuấn Khải', '2022-03-30', '2022-03-31',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (8, N'Nguyễn Gia Hân', '2022-03-31', '2022-04-03',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (9, N'Phan Minh Hoàng', '2022-04-01', '2022-04-02',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (10, N'Trần Quốc Vinh', '2022-03-30', '2022-04-02',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (11, N'Lê Trương Thảo Uyên', '2022-04-02', '2022-04-06',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (12, N'Nguyễn Dương Giang', '2022-04-02', '2022-04-06',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (13, N'Phạm Đức Thiện', '2022-04-02', '2022-04-07',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (14, N'Nguyễn Thị Hồng Mỹ', '2022-04-02', '2022-04-06',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (15, N'Nguyễn Xuân Hiệp', '2022-04-01', '2022-04-05',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (16, N'Nguyễn Thị Kim Ngân', '2022-04-01', '2022-04-03',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (17, N'Phan Thị Trà My', '2022-04-01', '2022-04-03',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (18, N'Dương Tuấn Anh', '2022-04-01', '2022-04-02',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (19, N'Nguyễn Thị Thu Trang', '2022-04-04', '2022-04-07',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (20, N'Dương Tấn Lực', '2022-04-03', '2022-04-04',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (21, N'Phạm Ngọc Như Ý', '2022-04-02', '2022-04-03',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (22, N'Nguyễn Hoàng Thắng', '2022-04-02', '2022-04-04',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (23, N'Dương Hoài An', '2022-04-05', '2022-04-09',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (24, N'Nguyễn Thị Hồng Nhung', '2022-04-05', '2022-04-09',null, 0, 4);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (25, N'Lâm Chánh Huy', '2022-04-05', '2022-04-10',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (26, N'Trương Thị Thanh Tuyền', '2022-04-05', '2022-04-10',null, 0, 4);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (27, N'Huỳnh Hồ Bảo Nhi', '2022-04-05', '2022-04-09',null, 0, 3);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (28, N'Huỳnh Thị Tuyết Loan', '2022-04-06', '2022-04-11',null, 0, 4);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (29, N'Tân Việt Duy Long', '2022-04-06', '2022-04-09',null, 0,1);
insert into CheckInOut (MaDatPhong, TenKH, NgayDatPhong, NgayTraPhong, PhiThuThem, TrangThai, MaNV) values (30, N'Dương Tuấn Anh', '2022-04-07', '2022-04-15',null, 0, 4);
---------------------------------------------------------------------------------------------------

----------------------------------------------------------------------
----------------- Lê Trương Thảo Uyên _ 19DH110822 -----------------------------------------------------------------
------ Dịch vụ ------------------------------------------------------------------------------------
Insert into DichVu (TenDichVu, LoaiDichVu, NgayBatDau, NgayKetThuc) values (N'Dọn Dẹp Phòng', N'Dịch Vụ Phòng', '2022-11-01', '2022-11-02');
Insert into DichVu (TenDichVu, LoaiDichVu, NgayBatDau, NgayKetThuc) values (N'Ăn Sáng Tại Phòng', N'Dịch Vụ Ăn Uống', '2022-11-03', '2022-11-03');
Insert into DichVu (TenDichVu, LoaiDichVu, NgayBatDau, NgayKetThuc) values (N'Tour Dạo Biển', N'Dịch Vụ Tour', '2022-11-05', '2022-11-05');
Insert into DichVu (TenDichVu, LoaiDichVu, NgayBatDau, NgayKetThuc) values (N'Bữa Ăn Tối Ngoài Biển', N'Dịch Vụ Ăn Uống', '2022-11-07', '2022-11-07');
Insert into DichVu (TenDichVu, LoaiDichVu, NgayBatDau, NgayKetThuc) values (N'Chèo thuyền Ngắm San Hô', N'Dịch Vụ Tour', '2022-11-11', '2022-11-11');
Insert into DichVu (TenDichVu, LoaiDichVu, NgayBatDau, NgayKetThuc) values (N'Trang Trí Phòng', N'Dịch Vụ Phòng', '2022-11-13', '2022-11-13');
Insert into DichVu (TenDichVu, LoaiDichVu, NgayBatDau, NgayKetThuc) values (N'Spa', N'Dịch Vụ Chăm Sóc', '2022-11-03', '2022-11-03');
Insert into DichVu (TenDichVu, LoaiDichVu, NgayBatDau, NgayKetThuc) values (N'Giặc Đồ ', N'Dịch Vụ Phòng', '2022-11-23', '2022-11-23');
Insert into DichVu (TenDichVu, LoaiDichVu, NgayBatDau, NgayKetThuc) values (N'Xe Đưa Đón', N'Dịch Vụ Xe', '2022-11-30', '2022-11-30');
Insert into DichVu (TenDichVu, LoaiDichVu, NgayBatDau, NgayKetThuc) values (N'Thuê Xe Máy', N'Dịch Vụ Xe', '2022-11-25', '2022-11-28');
Insert into DichVu (TenDichVu, LoaiDichVu, NgayBatDau, NgayKetThuc) values (N'Đi Đảo', N'Dịch Vụ Tour', '2022-11-15', '2022-11-15');
------ Đặt dịch vụ ---------------------------------------------------------------------------------
Insert into DatDichVu (MaPhong, MaDichVu, SoLuong) values (101, 1, 2);
Insert into DatDichVu (MaPhong, MaDichVu, SoLuong) values (102, 3, 3);
Insert into DatDichVu (MaPhong, MaDichVu, SoLuong) values (103, 6, 2);
Insert into DatDichVu (MaPhong, MaDichVu, SoLuong) values (104, 1, 2);
Insert into DatDichVu (MaPhong, MaDichVu, SoLuong) values (105, 8, 1);
Insert into DatDichVu (MaPhong, MaDichVu, SoLuong) values (301, 1, 1);
Insert into DatDichVu (MaPhong, MaDichVu, SoLuong) values (202, 6,1);
Insert into DatDichVu (MaPhong, MaDichVu, SoLuong) values (203, 1, 2);
Insert into DatDichVu (MaPhong, MaDichVu, SoLuong) values (204, 1, 2);
Insert into DatDichVu (MaPhong, MaDichVu, SoLuong) values (205, 1, 2);
------ Tiện ích resort ------------------------------------------------------------------------------
Insert into TienIchResort (TenTienIch) values (N'Buffet Sáng');
Insert into TienIchResort (TenTienIch) values (N'Xe Đưa Đón Trong Resort');
Insert into TienIchResort (TenTienIch) values (N'WiFi Miễn Phí');
Insert into TienIchResort (TenTienIch) values (N'Bãi Biển Riêng');
Insert into TienIchResort (TenTienIch) values (N'Bãi Đậu Xe Hơi, Xe Máy');
Insert into TienIchResort (TenTienIch) values (N'Hồ Bơi Riêng');
Insert into TienIchResort (TenTienIch) values (N'Phòng Gym');
Insert into TienIchResort (TenTienIch) values (N'Khuôn Viên');
Insert into TienIchResort (TenTienIch) values (N'Mượn Xe Đạp Miễn Phí');
Insert into TienIchResort (TenTienIch) values (N'Đổi Tiền Tệ Tại Resort');
------ Đặt tiện ích ----------------------------------------------------------------------------------
Insert into DatTienIchResort (MaPhong, MaTienIch, TenKH) values (101, 1, N'Vũ Phương An');
Insert into DatTienIchResort (MaPhong, MaTienIch, TenKH) values (102, 2, N'Huỳnh Duy Khang');
Insert into DatTienIchResort (MaPhong, MaTienIch, TenKH) values (105, 6, N'Trần Quốc Tú');
Insert into DatTienIchResort (MaPhong, MaTienIch, TenKH) values (301, 3, N'Lê Trương Thảo Uyên');
Insert into DatTienIchResort (MaPhong, MaTienIch, TenKH) values (105, 7, N'Nguyễn Thị Hồng Mỹ');
Insert into DatTienIchResort (MaPhong, MaTienIch, TenKH) values (302, 8, N'Nguyễn Hồng Thắng');
Insert into DatTienIchResort (MaPhong, MaTienIch, TenKH) values (303, 3, N'Lâm Chánh Huy');
Insert into DatTienIchResort (MaPhong, MaTienIch, TenKH) values (104, 10, N'Huỳnh Hồ Bảo Nhi');
Insert into DatTienIchResort (MaPhong, MaTienIch, TenKH) values (201, 1, N'Dương Tuấn Anh');
Insert into DatTienIchResort (MaPhong, MaTienIch, TenKH) values (203, 5, N'Phạm Đức Thiện');
------ Thống kê doanh thu ----------------------------------------------------------------------------
Insert into ThongKeDoanhThu (ThangThongKe, NgayBatDau, NgayKetThuc, ChiTiet, TongDoanhThu, MaNV) values (2021-01-01,2021-01-01, 2022-01-30, N'Doanh thu tháng 1/2021', 10000000, 1 );
Insert into ThongKeDoanhThu (ThangThongKe, NgayBatDau, NgayKetThuc, ChiTiet, TongDoanhThu, MaNV) values (2021-02-01,2021-02-01, 2022-02-30, N'Doanh thu tháng 2/2021', 12300000, 3 );
Insert into ThongKeDoanhThu (ThangThongKe, NgayBatDau, NgayKetThuc, ChiTiet, TongDoanhThu, MaNV) values (2021-03-01,2021-03-01, 2022-03-30, N'Doanh thu tháng 3/2021', 11500000, 2 );
Insert into ThongKeDoanhThu (ThangThongKe, NgayBatDau, NgayKetThuc, ChiTiet, TongDoanhThu, MaNV) values (2021-04-01,2021-04-01, 2022-04-30, N'Doanh thu tháng 4/2021', 93000000, 1 );
Insert into ThongKeDoanhThu (ThangThongKe, NgayBatDau, NgayKetThuc, ChiTiet, TongDoanhThu, MaNV) values (2021-05-01,2021-05-01, 2022-05-30, N'Doanh thu tháng 5/2021', 100000000, 4 );
Insert into ThongKeDoanhThu (ThangThongKe, NgayBatDau, NgayKetThuc, ChiTiet, TongDoanhThu, MaNV) values (2021-06-01,2021-06-01, 2022-06-30, N'Doanh thu tháng 6/2021', 85000000, 5 );
Insert into ThongKeDoanhThu (ThangThongKe, NgayBatDau, NgayKetThuc, ChiTiet, TongDoanhThu, MaNV) values (2021-07-01,2021-07-01, 2022-07-30, N'Doanh thu tháng 7/2021', 87000000, 1 );
Insert into ThongKeDoanhThu (ThangThongKe, NgayBatDau, NgayKetThuc, ChiTiet, TongDoanhThu, MaNV) values (2021-08-01,2021-08-01, 2022-08-30, N'Doanh thu tháng 8/2021', 90000000, 1 );
Insert into ThongKeDoanhThu (ThangThongKe, NgayBatDau, NgayKetThuc, ChiTiet, TongDoanhThu, MaNV) values (2021-09-01,2021-09-01, 2022-09-30, N'Doanh thu tháng 9/2021', 110000000, 3 );
Insert into ThongKeDoanhThu (ThangThongKe, NgayBatDau, NgayKetThuc, ChiTiet, TongDoanhThu, MaNV) values (2021-10-01,2021-10-01, 2022-10-30, N'Doanh thu tháng 10/2021', 154000000, 4 );
---------------- Các câu truy vấn ---------------------------------------------------------------------------
--- câu lệnh SQL 1 bảng
--- câu 2.1: Tổng doanh thu
Select sum(TongDoanhThu)
from ThongKeDoanhThu


--- câu 2.2: Dịch vụ phòng 101 đặt
Select *
from DatDichVu
where MaPhong = 101

--- câu 2.3: Doanh thu tháng 1
Select TongDoanhThu
from ThongKeDoanhThu
where ThangThongKe = 2021-01-01

--- câu 2.4: Thông tin dịch vụ đi đảo
Select *
from DatDichVu
where MaPhong = 101

--- câu lệnh SQL 2 bảng: 
--- Câu 2.5 xem phòng 101 đặt tiện ích gì

select * 
from DatTienIchResort d, TienIchResort t
where d.MaTienIch = t.MaTienIch and d.MaPhong = 101

--- Câu 2.6 xem phòng 101 đặt dịch vụ gì
select * 
from DatDichVu ddv, DichVu dv
where ddv.MaDichVu = dv.MaDichVu and ddv.MaPhong = 101

--- Câu 2.7 xem có phòng nào đặt spa
select * 
from DatDichVu ddv, DichVu dv
where ddv.MaDichVu = dv.MaDichVu and dv.TenDichVu = 'Spa'

--- Câu 2.8 xem khách hàng nào đặt Buffet sáng
select * 
from DatTienIchResort d, TienIchResort t
where d.MaTienIch = t.MaTienIch and t.TenTienIch = N'Buffet Sáng'
------------- Các Store Procedure --------------------------------------------
--- Câu 3: stored procedure
--- 3.1. Kiểm tra khách hàng Vũ Phương an có đặt dịch vụ không
go;

CREATE PROCEDURE KiemTraKH @TenKH nvarchar(50)
AS
SELECT * FROM DatTienIchResort WHERE TenKH = @TenKH;
GO;

EXEC KiemTraKH @TenKH = N'Vũ Phương An';
Go;

--- 3.2. xem phòng có mã đố đặt gì đặt tiện ích gì
CREATE PROCEDURE KiemTraPhong @MaPhong smallint
AS
select * 
from DatTienIchResort d, TienIchResort t
where d.MaTienIch = t.MaTienIch and d.MaPhong = @MaPhong

GO;

EXEC KiemTraPhong @MaPhong = 101;
go

--- 3.3. Xem tổng doanh thu của tháng được cho


CREATE PROCEDURE KiemTraDoanhThu @Thang smalldatetime
AS
Select TongDoanhThu
from ThongKeDoanhThu
where ThangThongKe = @Thang
go;

EXEC KiemTraDoanhThu @Thang = '2021-01-01';
go;



--- 3.4. xem có phòng nào đặt spa
CREATE PROCEDURE KiemTraDV @TenDV varchar(30)
AS
select * 
from DatDichVu ddv, DichVu dv
where ddv.MaDichVu = dv.MaDichVu and dv.TenDichVu =  @TenDV
go;

EXEC KiemTraDV @TenDV = 'Spa';
go;


--- 3.5. xem khách hàng nào đặt tiện ích nào
CREATE PROCEDURE KiemTraTienIch @TenTI varchar(30)
AS
select * 
from DatTienIchResort d, TienIchResort t
where d.MaTienIch = t.MaTienIch and t.TenTienIch = N'Buffet Sáng'
go

EXEC KiemTraTienIch @TenTI = N'Buffet Sáng';
go

------------- Các View hiện dữ liệu --------------------------------------------
--- Câu 4
CREATE VIEW XemDoanhThu AS
Select TongDoanhThu
from ThongKeDoanhThu
where ThangThongKe = 2021-01-01

go

CREATE VIEW XemTienIch AS
select d.*, t.TenTienIch
from DatTienIchResort d, TienIchResort t
where d.MaTienIch = t.MaTienIch
go


CREATE VIEW XemDichVu AS
select ddv.*, dv.LoaiDichVu, dv.NgayBatDau, dv.NgayKetThuc, dv.TenDichVu
from DatDichVu ddv, DichVu dv
where ddv.MaDichVu = dv.MaDichVu
go

CREATE VIEW XemKhachHang AS
SELECT * 
FROM DatTienIchResort 
go
---------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------
----------------- Vũ Phương An _ 19DH110766 -----------------------------------------------------------------
---------------- Các câu truy vấn ---------------------------------------------------------------------------
------ Truy vấn từ 1 bảng -----------------------------------------------
--- 1. In ra danh sách các tài khoản có mã phân quyền là 2 trong bảng Tài Khoản (Khách Hàng)
select UserName, Passwordd
from TaiKhoan
where MaPQ = 2
--- 2. Đếm số tài khoản có mã phân quyền là 2 trong bảng Tài Khoản (Khách hàng)
select count (mapq) as 'Số lượng khách hàng'
from TaiKhoan
where MaPQ =2
--- 3. In ra danh sách các đơn đặt có mã phương thức thanh toán là 1 (Thanh toán bằng tiền mặt)
select MaDatPhong, MaPhong, TenKH
from DatPhong
where MaPhuongThuc = 1
--- 4. In ra danh sách các đơn đặt phòng trong ngày 2022-03-30
select MaDatPhong, MaPhong, TenKH, NgayDatPhong, NgayTraPhong
from DatPhong
where NgayDatPhong = '2022-03-30' 
--- 5. Tính tổng các đơn đặt phòng trong ngày 2022-03-30
select count (*) as 'Số lượng đơn đặt phòng'
from DatPhong
where MaDatPhong IN (select MaDatPhong
						from DatPhong
						where NgayDatPhong = '2022-03-30')
--- 6. In ra danh sách các nhân viên có giới tính là nữ và có mã chức vụ là 2 (Quản lý)
select MaNV, HoTen, GioiTinh, NgaySinh, DiaChi, MaChucVu
from NhanVien
where GioiTinh= N'Nữ' and MaChucVu =2
--- 7. Tính tổng số nhân viên có chức vụ là nhân viên phòng (mã chức vụ là 1) và có giới tính là nam
select count(*) as 'Số lượng nhân viên'
from NhanVien
where MaNV IN (select MaNV
				from NhanVien
				where MaChucVu =1 and GioiTinh = N'Nam')
----------------------------------------------------------------

------ Truy vấn từ nhiều bảng ------------------------------------
--- 1. In ra danh sách các khách hàng đã đặt phòng ngày 2022-04-02
select kh.MaKH, kh.HoTen, dp.MaDatPhong, dp.NgayDatPhong
from KhachHang kh, DatPhong dp
where kh.HoTen  = dp.TenKH collate SQL_Latin1_General_CP1_CI_AS  
AND dp.NgayDatPhong = '2022-04-02'
--- 2. Tính số lượng các khách hàng trả phòng vào ngày 2022-04-06
select count (*) as 'Số lượng trả phòng'
from DatPhong dp, KhachHang kh
where NgayTraPhong = '2022-04-06' 
and kh.HoTen  = dp.TenKH collate SQL_Latin1_General_CP1_CI_AS
--- 3. In ra danh sách đặt phòng có sử dụng mã phương thức thanh toán là 3 (Ví Momo)
select dp.MaDatPhong, dp.TenKH, dp.MaPhong, dp.NgayDatPhong, pt.TenPhuongThuc
from PhuongThucThanhToan pt, DatPhong dp
where pt.MaPhuongThuc = dp.MaPhuongThuc 
and dp.MaPhuongThuc =3
--- 4. In ra danh sách các khách hàng đặt phòng có đơn giá là 6000000
select dp.MaDatPhong, pxn.TenKH, dp.MaPhong, pxn.MaPhieuXacNhan, pxn.DonGia, pxn.NgayDatPhong, pxn.NgayTraPhong
from  DatPhong dp, PhieuXacNhanDatPhong pxn
where  pxn.DonGia = '6000000'
and dp.MaDatPhong = pxn.MaDatPhong
--- 5. In ra danh sách tên Nhân Viên làm thủ tục checkinout từ ngày '2022-03-30' đến ngày '2022-04-10'
select nv.MaNV, nv.HoTen, c.MaDatPhong, c.NgayDatPhong, c.NgayTraPhong
from CheckInOut c, NhanVien nv
where c.MaNV = nv.MaNV
and c.NgayDatPhong BETWEEN '2022-03-30' AND '2022-04-10'
--------------------------------------------------------------------------------

------------- Các View hiện dữ liệu --------------------------------------------
--- 1. Tạo View hiển thị thông tin Nhân Viên
create view ThongTinNhanVien AS
select nv.MaNV, nv.HoTen, nv.GioiTinh, nv.MaChucVu, cv.TenChucVu
from NhanVien nv, ChucVu cv
where nv.MaChucVu = cv.MaChucVu

select * from ThongTinNhanVien
--- 2. Tạo View hiển thị thông tin Phòng
create view ThongTinDatPhong as
select dp.MaDatPhong, dp.TenKH, dp.MaPhong, p.MaLoai, lp.TenLoai, p.MoTaThongTin, p.DonGia, pt.TenPhuongThuc, dp.NgayDatPhong, dp.NgayTraPhong, dp.YeuCauThem
from DatPhong dp, Phong p, PhuongThucThanhToan pt, LoaiPhong lp
where dp.MaPhong =p.MaPhong
and p.MaLoai = lp.MaLoai
and dp.MaPhuongThuc = pt.MaPhuongThuc

select * from ThongTinDatPhong
--- 3. Tạo View hiển thị Danh sách tài khoản là Khách hàng
create view DanhSachTaiKhoanKhachHang as
select tk.MaTaiKhoan, tk.UserName, tk.Passwordd, tk.MaPQ, pq.TenPQ
from TaiKhoan tk, PhanQuyen pq
where tk.MaPQ = pq.MaPQ
and tk.MaPQ = 2

select * from DanhSachTaiKhoanKhachHang
--- 4. Tạo View hiển thị thông tin checkinout
create view ThongTinCheckInOut as
select dp.MaDatPhong, c.TenKH, c.NgayDatPhong, c.NgayTraPhong, c.PhiThuThem, c.TrangThai, c.MaNV, nv.HoTen as 'Nhân Viên thực hiện'
from CheckInOut c, NhanVien nv, DatPhong dp
where dp.MaDatPhong = c.MaDatPhong
and c.MaNV= nv.MaNV

select * from ThongTinCheckInOut
------------------------------------------------------------------------------

------------- Các Store Procedure --------------------------------------------
--- 1. Tạo sp để thêm nhân viên, nếu thông tin nhân viên đã tồn tại thì báo lỗi.
create proc sp_ThemNhanVien
(
	@HOTEN nvarchar(50),
	@GIOITINH nvarchar(5),
	@NGAYSINH smalldatetime,
	@DIACHI nvarchar(150),
	@MACHUCVU smallint,
	@MATAIKHOAN smallint
	)
as
begin
	if exists (select * from NhanVien
				where @HOTEN= HoTen and @GIOITINH = GioiTinh 
					and @DIACHI= DiaChi and @NGAYSINH = NgaySinh 
					and @MACHUCVU= MaChucVu)
	begin
		print N'Thông tin nhân viên đã tồn tại'
		return
	end
	else
		insert into NhanVien
		values (@HOTEN, @GIOITINH, @NGAYSINH,@DIACHI, @MACHUCVU, @MATAIKHOAN)
		print N'Thêm thông tin nhân viên thành công'
end
-- Thêm thông tin nhân viên đã tồn tại
exec sp_ThemNhanVien N'Vũ Phương An',N'Nữ','2001-09-06',N'52 Nguyễn Thái Bình', 2, null
delete from NhanVien where MaNV=12
-- Thêm thông tin nhân viên mới
exec sp_ThemNhanVien N'Hoàng Thanh Dung', N'Nữ', '1998-07-25', N'75 Lý Thường Kiệt', 1, null
----------------------------------------------------------------------------------------------
--- 2. Tạo sp để hiển thị thông tin đặt phòng.
create proc sp_ThongTinDatPhong
	@MADATPHONG smallint
as
begin
	if not exists (select * from PhieuXacNhanDatPhong where @MADATPHONG = MaDatPhong)
	begin
		print N'Mã đặt phòng không tồn tại'
		return
	end
	else
	begin
		select dp.MaDatPhong, dp.MaPhong, pxn.MaPhieuXacNhan, dp.TenKH, dp.NgayDatPhong, dp.NgayTraPhong, pxn.DonGia, pxn.TrangThaiDatPhong, pxn.YeuCauThem, pt.TenPhuongThuc as 'Phương Thức Thanh Toán'
		from DatPhong dp, PhieuXacNhanDatPhong pxn, PhuongThucThanhToan pt
		where dp.MaDatPhong = pxn.MaDatPhong
		and pt.MaPhuongThuc = pxn.MaPhuongThuc
		and pxn.MaDatPhong =@MADATPHONG
		group by dp.MaDatPhong, dp.MaPhong, pxn.MaPhieuXacNhan, dp.TenKH, dp.NgayDatPhong, dp.NgayTraPhong, pxn.DonGia, pxn.TrangThaiDatPhong, pxn.YeuCauThem, pt.TenPhuongThuc
	end
end

--- Thông tin đúng
exec sp_ThongTinDatPhong 6
--- Thông tin sai
exec sp_ThongTinDatPhong 10000
-----------------------------------------------------------------------------------
--- 3. Tạo sp để hiển thị thông tin đặt phòng thành công.
create proc sp_ThongTinDatPhongThanhCong
as
begin
	begin
		select dp.MaDatPhong, dp.MaPhong, pxn.MaPhieuXacNhan, dp.TenKH, dp.NgayDatPhong, dp.NgayTraPhong, pxn.DonGia, pxn.TrangThaiDatPhong, pxn.YeuCauThem, pt.TenPhuongThuc as 'Phương Thức Thanh Toán'
		from DatPhong dp, PhieuXacNhanDatPhong pxn, PhuongThucThanhToan pt
		where dp.MaDatPhong = pxn.MaDatPhong
		and pt.MaPhuongThuc = pxn.MaPhuongThuc
		and pxn.TrangThaiDatPhong = N'Thành công' 
		group by dp.MaDatPhong, dp.MaPhong, pxn.MaPhieuXacNhan, dp.TenKH, dp.NgayDatPhong, dp.NgayTraPhong, pxn.DonGia, pxn.TrangThaiDatPhong, pxn.YeuCauThem, pt.TenPhuongThuc
	end
end

exec sp_ThongTinDatPhongThanhCong
-----------------------------------------------------------------------------------
--- 4. Tạo sp nhập thông tin ngày đặt phòng, hiển thi thông tin đặt phòng.
create proc sp_NgayDatPhong
	@NGAYDATPHONG smalldatetime
as
begin
	if not exists (select * from PhieuXacNhanDatPhong where @NGAYDATPHONG = NgayDatPhong)
	begin
		print N'Không có ngày đặt phòng này'
		return
	end
	else
	begin
		select dp.MaDatPhong, dp.MaPhong, pxn.MaPhieuXacNhan, dp.TenKH, dp.NgayDatPhong, dp.NgayTraPhong, pxn.DonGia, pxn.TrangThaiDatPhong, pxn.YeuCauThem, pt.TenPhuongThuc as 'Phương Thức Thanh Toán'
		from DatPhong dp, PhieuXacNhanDatPhong pxn, PhuongThucThanhToan pt
		where dp.MaDatPhong = pxn.MaDatPhong
		and pt.MaPhuongThuc = pxn.MaPhuongThuc
		and pxn.NgayDatPhong =@NGAYDATPHONG
		group by dp.MaDatPhong, dp.MaPhong, pxn.MaPhieuXacNhan, dp.TenKH, dp.NgayDatPhong, dp.NgayTraPhong, pxn.DonGia, pxn.TrangThaiDatPhong, pxn.YeuCauThem, pt.TenPhuongThuc
	end
end

exec sp_NgayDatPhong '2022-04-02'
-----------------------------------------------------------------------------------
--- 5. Tạo sp để thêm tài khoản.
create proc sp_ThemTaiKhoan
	@USERNAME nvarchar(150),
	@PASSWORDD nvarchar(150),
	@MAPQ smallint,
	@MAKH smallint,
	@MANV smallint
as
begin
	if exists (select * from TaiKhoan
				where @USERNAME = UserName and @PASSWORDD = Passwordd)
	begin
		print N'Thông tin tài khoản đã tồn tại'
		return
	end
	else
	begin
		insert into TaiKhoan
		values (@USERNAME, @PASSWORDD, @MAPQ, @MAKH, @MANV)
		print N'Thêm tài khoản thành công'
	end
end

---- Thêm thông tin đã tồn tại
exec sp_ThemTaiKhoan N'dnhuu', N'dnhu123', 2, 1, null
---- Thêm thông tin mới
exec sp_ThemTaiKhoan N'anuuu', N'anu060901', 2, null, null

select * from TaiKhoan
---------------------------------------------------------------------------------------------------------------------
----------------- Dương Thị Tuyết Như _ 19DH110140 -----------------------------------------------------------------
--- 1 BẢNG
---CÂU 1: Xem thông tin của khách hàng là nam, sinh ngày 27-10-1998
SELECT *
FROM KhachHang
WHERE GioiTinh='Nam' and NgaySinh='1998-10-27'

---Câu 2: Xem Phòng có 2 giường và giá trong khoảng từ 3000000 đến 4000000
SELECT *
FROM Phong
WHERE SoGiuong = 2 AND DonGia BETWEEN '3000000' AND '4000000'

---CÂU 3: Xem Phòng số 502 có giá là bao nhiêu tiền
SELECT MaPhong, DonGia 
FROM DonGiaPhong
WHERE MaPhong='502'

---CÂU 4: Xem chi tiết phòng Superior 2 giường đơn
SELECT *
FROM LoaiPhong
WHERE TenLoai = N'Superior 2 giường đơn'

--- NHIỀU BẢNG
---CÂU 1: Đếm Số phòng có mã loại là 44 có bao nhiêu phòng
SELECT count(*) as TongSoPhong
FROM LoaiPhong lp, Phong p
WHERE lp.MaLoai = p.MaLoai and p.MaLoai='44'

---CÂU 2: Xem giá của các loại phòng hiện có
SELECT distinct lp.MaLoai, lp.TenLoai, dgp.DonGia
FROM LoaiPhong lp, DonGiaPhong dgp
WHERE lp.MaLoai = dgp.MaLoai 

---CÂU 3: Xem thông tin chi tiết của các phòng có 1 giường
SELECT p.MaPhong, p.SoGiuong, p.DonGia, lp.ChiTiet
FROM LoaiPhong lp, Phong p
WHERE lp.MaLoai = p.MaLoai and p.SoGiuong = 1

---CÂU 4: Xem biệt thự biển giá bao nhiêu
SELECT lp.*, dgp.DonGia
FROM LoaiPhong lp, DonGiaPhong dgp
WHERE lp.MaLoai = dgp.MaLoai and lp.MaLoai = '66'

--- Store procedure
---Câu 1: Tạo sp để xem chi tiết thông tin khách hàng
CREATE PROC  sp_XemChiTietKhachHang @MaKH smallint
AS
BEGIN
	SELECT *
	FROM KhachHang
	WHERE MaKH = @MaKH
END

EXEC sp_XemChiTietKhachHang 12

---Câu 2: Tạo sp để thêm phòng
create proc sp_ThemPhong
	@MAPHONG smallint,
	@MALOAI smallint,
	@SOGIUONG smallint,
	@HINHANH nvarchar(max),
	@DONGIA decimal(18,2),
	@MOTATHONGTIN nvarchar(max),
	@TRANGTHAI nvarchar(25)
as
begin
	if exists (select * from Phong
				where @MAPHONG = MaPhong and @MALOAI = MaLoai
				and @SOGIUONG = SoGiuong and @HINHANH = HinhAnh
				and @DONGIA = DonGia and @TRANGTHAI = TrangThai)
	begin
		print N'Thông tin phòng đã tồn tại'
		return
	end
	else
	begin
		insert into Phong
		values (@MAPHONG, @MALOAI, @SOGIUONG, @HINHANH, @DONGIA, @MOTATHONGTIN, @TRANGTHAI)
		print N'Thêm phòng thành công'
	end
end

---- Thêm thông tin đã tồn tại
exec sp_ThemPhong 401, 11, 3, '' , '10000000', N'Thoải mái và đầy phong cách, Phòng Gia đình Cao cấp của chúng tôi là một lựa chọn cho các nhóm hoặc gia đình đông người. Trong căn phòng chính có thêm bồn ngâm độc lập, khu vực tiếp khách, góc đọc sách và hai ghế sofa; căn phòng còn lại được trang bị đầy đủ tiện nghi để mang đến một kỳ nghỉ thư giãn cho tất cả mọi người.', 0
---- Thêm thông tin mới
exec sp_ThemPhong 701, 77, 4, '' , '20000000', N'Thoải mái và đầy phong cách, kỳ nghỉ thư giãn cho tất cả mọi người.', 0

---Câu 3: Nhập mã phòng để hiển thị thông tin
CREATE PROC  sp_XemThongTinPhong @MaPhong smallint
AS
BEGIN
	SELECT lp.TenLoai, p.*
	FROM LoaiPhong lp, Phong p 
	WHERE lp.MaLoai = p.MaLoai and p.MaPhong = @MaPhong
END;

EXEC sp_XemThongTinPhong 404

---Câu 4: Nhập mã phòng để hiển thị thông tin đơn giá phòng
CREATE PROC  sp_XemDonGiaPhong @MaPhong smallint
AS
BEGIN
	SELECT p.MaPhong, dgp.DonGia
	FROM DonGiaPhong dgp, Phong p 
	WHERE dgp.MaLoai = p.MaLoai and p.MaPhong = @MaPhong
END;

EXEC sp_XemThongTinPhong 502

---Câu 5: Nhập tên khách hàng để hiển thị thông tin
CREATE PROC  sp_XemThongTinKhachHang @HoTen nvarchar(50)
AS
BEGIN
	SELECT *
	FROM KhachHang
	WHERE HoTen = @HoTen
END;

EXEC sp_XemThongTinKhachHang N'Đỗ Tuấn Khải'


--- VIEW
---Câu 1:
CREATE VIEW KhachHangNu AS
SELECT *
FROM KhachHang
WHERE GioiTinh = N'Nữ'

GO

---Câu 2:
CREATE VIEW XemTenPhong AS
SELECT p.MaPhong, lp.TenLoai
FROM LoaiPhong lp, Phong p
WHERE lp.MaLoai = p.MaLoai

GO

select * from XemTenPhong

---Câu 3:
CREATE VIEW XemThongTinPhong1Giuong AS
SELECT p.MaPhong, lp.TenLoai, p.SoGiuong, p.DonGia  
FROM Phong p, LoaiPhong lp 
WHERE p.MaLoai=lp.MaLoai and  p.SoGiuong = 1

GO

select * from XemThongTinPhong1Giuong
---Câu 4: 
CREATE VIEW XemCacPhongGiaDinh AS
SELECT p.*
FROM LoaiPhong lp, Phong p
WHERE lp.MaLoai=p.MaLoai

GO

----------------------------------------------------------------------
----------------- Lê Trương Thảo Uyên _ 19DH110822 -----------------------------------------------------------------
use QLResort
go

--- Dichvu, dat dich vụ, tiện ích resort, đặt tiện ích, thống kê doanh thu

select * from DichVu
select * from DatDichVu
select * from TienIchResort
select * from DatTienIchResort
select * from ThongKeDoanhThu
go

--- 5 functions
--- 1. Nhập mã phòng cho biết số lượng dịch vụ đã đặt
drop function f_ThongKeDV_SoLuong
go 

Create function f_ThongKeDV_SoLuong (@MaPhong smallint)
returns int as 
begin
	DECLARE @ret int;
	select @ret = count(*) from DatDichVu where MaPhong = @MaPhong
	return @ret
end
go

select dbo.f_ThongKeDV_SoLuong(101)
go

--- 2. Nhập mã phòng cho biết tên tiện ích và số lượng tiện ích đã đặt
drop function f_ThongKeTienIch_SoLuong
go 

Create function f_ThongKeTienIch_SoLuong (@MaPhong smallint)
returns int as 
begin
	DECLARE @ret int;
	select @ret = count(*) from DatTienIchResort where MaPhong = @MaPhong
	return @ret
end
go

select dbo.f_ThongKeTienIch_SoLuong(101)

--- 3. Nhập mã nhân viên cho biết số tổng doanh thu theo tháng
drop function f_ThongKeDoanhThu_NV
go 

Create function f_ThongKeDoanhThu_NV (@MaNV int)
returns decimal as 
begin
	DECLARE @ret decimal;
	select @ret = sum(TongDoanhThu) from ThongKeDoanhThu where MaNV = @MaNV
	return @ret
end
go

select dbo.f_ThongKeDoanhThu_NV(1)
go



--- 4. Nhập loại dịch vụ cho biết tổng số lượng đặt
drop function f_ThongKeLoaiDV_SoLuong
go 

Create function f_ThongKeLoaiDV_SoLuong (@LoaiDV nvarchar(50))
returns int as 
begin
	DECLARE @ret int;
	select @ret = sum(d.SoLuong) from DatDichVu d, DichVu dv where d.MaDichVu = dv.MaDichVu and @LoaiDV = dv.LoaiDichVu
	return @ret
end
go

select dbo.f_ThongKeLoaiDV_SoLuong(N'Dịch Vụ Phòng')
go



--- 5. Nhập tên tiện ích cho biết số phòng đang đặt
drop function f_ThongKeTienIch_Phong
go 

Create function f_ThongKeTienIch_Phong (@TenTI nvarchar(50))
returns int as 
begin
	DECLARE @ret int;
	select @ret = count(*) from TienIchResort t, DatTienIchResort d where t.MaTienIch = d.MaTienIch and t.TenTienIch = @TenTI
	return @ret
end
go


select count(*) from TienIchResort t, DatTienIchResort d where t.MaTienIch = d.MaTienIch and t.TenTienIch = N'Buffet Sáng'
select dbo.f_ThongKeTienIch_Phong(N'Buffet Sáng')
go
--- 5 triggers cho phép kiểm soát ràng buộc dữ liệu, đồng bộ dữ liệu
--- 1. Kiểm tra ngày đặt dịch vụ đúng
drop trigger trg_KiemTraNgay
go
CREATE TRIGGER trg_KiemTraNgay
ON DichVu 
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @NgayBatDau smalldatetime
	DECLARE @NgayKetThuc smalldatetime
	SELECT @NgayBatDau = NgayBatDau, @NgayKetThuc = NgayKetThuc FROM inserted
	if (@NgayBatDau >= @NgayKetThuc)
	BEGIN
		Rollback
		PRINT 'Ngay bat dau phai nho hon ngay ket thuc'
	END
END
go

insert into DichVu Values (N'Dọn Dẹp Phòng', 'Dịch Vụ Phòng', '2022-11-03 00:00:00', '2022-11-02 00:00:00')

--- 2. Kiểm tra Doanh thu âm
drop trigger trg_KiemTraDoanhThu
go
CREATE TRIGGER trg_KiemTraDoanhThu
ON ThongKeDoanhThu 
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @TongDoanhThu decimal
	SELECT @TongDoanhThu = TongDoanhThu FROM inserted
	if (@TongDoanhThu < 0)
	BEGIN
		Rollback
		PRINT 'Doanh Thu phải là so duong'
	END
END
go

insert into ThongKeDoanhThu Values ('1905-07-13 00:00:00', '1905-07-13 00:00:00', '1905-06-15 00:00:00', N'Doanh thu tháng 1/2022', 1, -100000000.00)

--- 3. Kiểm tra tên dịch vụ bị trùng
drop trigger trg_KiemTraTenDichVu
go
CREATE TRIGGER trg_KiemTraTenDichVu
ON DichVu 
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @TenDV nVarchar(50)
	SELECT @TenDV = TenDichVu FROM inserted
	if ((Select Count(*) from DichVu Where TenDichVu = @TenDV) > 1)
	BEGIN
		Rollback
		PRINT N'Tên Dịch vụ duy nhất'
	END
END
go

insert into DichVu Values (N'Dọn Dẹp Phòng', 'Dịch Vụ Phòng', '2022-11-01 00:00:00', '2022-11-02 00:00:00')

--- 4. Dịch vụ trang trí phòng không được đặt 2 lần

drop trigger trg_KiemTraDatDichVu
go
CREATE TRIGGER trg_KiemTraDatDichVu
ON DatDichVu 
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @MaDV smallint
	DECLARE @SoLuong smallint
	SELECT @MaDV = MaDichVu, @SoLuong = SoLuong FROM inserted
	if (@SoLuong > 1)
	BEGIN
		if exists(Select * from DichVu where MaDichVu = @MaDV and TenDichVu = N'Trang Trí Phòng')
		BEGIN
			Rollback
			PRINT N'Chỉ được đặt 1 lần trang trí phòng'
		END
	END
END
go

insert into DatDichVu Values (101, 6, 2)


--- 5. Khách đặt buffet sáng sẽ được tặng kèm tiện ích xe đưa đón trong resort
drop trigger trg_DatTienIchResort_Buffet
go
CREATE TRIGGER trg_DatTienIchResort_Buffet
ON DatTienIchResort 
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @MaTI smallint
	DECLARE @MaPhong smallint
	DECLARE @TenKH nVarchar(50)
	SELECT @MaTI = MaTienIch, @MaPhong = MaPhong, @TenKH = TenKH FROM inserted
	if exists(Select * from TienIchResort where MaTienIch = @MaTI and TenTienIch = N'Buffet Sáng')
	BEGIN
		DECLARE @MaTI_Xe smallint
		SELECT @MaTI_Xe = MaTienIch FROM TienIchResort where TenTienIch = N'Xe Đưa Đón Trong Resort'
		Insert into DatTienIchResort Values (@MaPhong, @MaTI_Xe, @TenKH)
		PRINT N'Bạn được tặng kèm dịch vụ đưa đón xe'
		
	END
END
go

select * from TienIchResort
select * from DatTienIchResort
insert into DatTienIchResort Values (601, 1, N'Vũ Phương An')

select * from DatTienIchResort

---------------------------------------------------------------------------------------------------------------------
----------------- Dương Thị Tuyết Như _ 19DH110140 -----------------------------------------------------------------
--- 5 functions
-- 1. Nhập mã loại cho biết số phòng loại đó chưa có khách đặt

create function f_PhongConTrongTheoLoai (@maloai smallint)
returns smallint as
begin
	declare @ret smallint;
	select @ret = MaPhong from Phong where MaLoai = @maloai and TrangThai = 0
	return @ret
end
go
-- 2. Nhập tên khách hàng cho biết phòng đã đặt
create function f_XemKhachDatPhong (@HoTen nvarchar(50))
returns smallint as
begin
	DECLARE @ret smallint;
	select @ret = MaPhong from DatPhong where TenKH = @HoTen
	return @ret
end
go

-- 3. Nhập tên phương thức thanh toán để hiển thị
create function f_TimloaiPTTT (@TenPTTT nvarchar(50))
returns nvarchar(50) as
begin
	DECLARE @ret nvarchar(50);
	select @ret = TenPhuongThuc from PhuongThucThanhToan where TenPhuongThuc = @TenPTTT
	return @ret
end
go

-- 4. Nhập số phòng cho biết khách hàng đã đặt
create function f_TimTheoSoPhong (@SoPhong smallint)
returns nvarchar(50) as
begin
	DECLARE @ret nvarchar(50);
	select @ret = TenKH from DatPhong where MaPhong = @SoPhong
	return @ret
end
go

-- 5. Nhập mã loại cho biết tổng số phòng thuộc loại đó
create function f_TongSoPhongTheoLoai (@maloai nvarchar(50))
returns int as
begin
	DECLARE @ret int;
	select @ret = COUNT(MaPhong) from Phong where MaLoai = @maloai
	return @ret
end
go

--- 5 trigger
-- 1. Kiểm tra thông tin khách hàng có trống hay không (khách hàng)
create trigger trg_KiemTraKH
On KhachHang
for insert, update
as
begin
	declare @MaKH smallint
	declare @HoTen smallint
	declare @GioiTinh nvarchar(5)
	declare @SoCMND bigint
	declare @SDT int 
	select @MaKH = MaKH, @HoTen = HoTen, @GioiTinh = GioiTinh, 
	@SoCMND = SoCMND, @SDT = SDT from inserted
	if (@MaKH = null or @HoTen = null or @GioiTinh = null or 
	@SoCMND = null or @SDT = null)
	begin
		rollback
		print 'Thông tin khách hàng không được để trống'
	end
end

-- 2. Kiểm tra loại phòng đã tồn tại hay không (loaiphong)
create trigger trg_KiemTraPhong
On LoaiPhong
for insert, update
as
begin
	declare @TenLoai nvarchar(255)
	select @TenLoai = TenLoai from inserted
	if ((select count(*) from LoaiPhong Where TenLoai = @TenLoai) > 1)
	begin
		rollback
		print 'Loại phòng đã tồn tại'
	end
end
-- 3. Kiểm tra đơn giá phòng, giá phải lớn hơn 0 (dongiaphong)
create trigger trg_KiemTraDonGiaPhong
On DonGiaPhong
for insert, update
as
begin
	declare @DonGia decimal(18,2)
	select @DonGia = DonGia from inserted
	if (@DonGia <= 0)
	begin
		rollback
		print 'Giá phải lớn hơn 0 đồng'
	end
end
-- 4. Kiểm tra trạng thái của phòng để đặt phòng (phong)
create trigger trg_KiemTraTrangThaiPhong
On Phong
for insert, update
as
begin
	declare @maphong smallint
	select @maphong = MaPhong from inserted
	if ((select TrangThai from Phong where @maphong = MaPhong) > 0)
	begin
		rollback
			print 'Phòng đã có khách đặt'
	end
end
-- 5. Kiểm tra ngày trả phòng phải lớn hơn ngày đặt phòng
create trigger trg_KiemTraNgayTraPhong
On DatPhong
for insert, update as
begin
	declare @ngaydatphong smalldatetime
	declare @ngaytraphong smalldatetime
	select @ngaytraphong = NgayTraPhong, @ngaydatphong = NgayDatPhong from inserted
	if (@ngaytraphong <= @ngaydatphong)
	begin
		rollback
		print 'Ngày trả phòng phải lớn ngày đặt phòng'
	end
end

---------------------------------------------------------------------------------------------------------------------
----------------- Vũ Phương An _ 19DH110766 -----------------------------------------------------------------
use QLResort
go
---- Function ----
--- 1. Viết hàm nhập mã phiếu xác nhận đặt phòng để hiển thị thông tin trạng thái đặt phòng
create function f_NhapMaXacNhanHienThiTrangThai (@MaPXN smallint)
returns nvarchar(25) as
begin
	declare @TrangThai nvarchar(25);
	select  @TrangThai = (select TrangThaiDatPhong
							from PhieuXacNhanDatPhong
							where MaPhieuXacNhan = @MaPXN)
	return @TrangThai
end

select dbo.f_NhapMaXacNhanHienThiTrangThai (25)
--- 2. Viết hàm nhập mã phiếu xác nhận đặt phòng để hiển thị đơn giá phòng
create function f_HienThiDonGiaPhong (@MaPXN smallint)
returns decimal(18,2) as
begin
	declare @DonGiaPhong decimal(18,2);
	set @DonGiaPhong = (select DonGia 
						from PhieuXacNhanDatPhong
						where MaPhieuXacNhan = @MaPXN)
	return @DonGiaPhong
end

select dbo.f_HIenThiDonGiaPhong (25)
--- 3. Viết hàm tính tổng ngày thuê phòng dựa vào mã đặt phòng (Bảng checkinout)
select * from CheckInOut
create function f_TongNgayThuePhong (@MaDatPhong smallint)
returns int as
begin
	declare @TongNgayThuePhong int;
	set @TongNgayThuePhong = (select sum (datediff(day, NgayDatPhong, NgayTraPhong))
								from CheckInOut
								where @MaDatPhong = MaDatPhong)
	return @TongNgayThuePhong
end

select dbo.f_TongNgayThuePhong (1)
select dbo.f_TongNgayThuePhong (2)
--- 4. Viết hàm tính số lượng phiếu xác nhận đặt phòng từ ngày bao nhiêu đến ngày bao nhiêu do 
--- nhân viên nhập vào
select * from PhieuXacNhanDatPhong
alter function f_SoLuongDatPhong (@NgayDatPhong smalldatetime, @NgayTraPhong smalldatetime)
returns int as
begin
	declare @SoLuongNgay int;
	set @SoLuongNgay = (select count(*)
						from PhieuXacNhanDatPhong
						where @NgayDatPhong = NgayDatPhong
						and @NgayTraPhong= NgayTraPhong)
	return @SoLuongNgay
end

select dbo.f_SoLuongDatPhong('2022-03-30', '2022-04-01')
--- 5. Viết hàm tính tổng tiền thuê phòng dựa vào mã đặt phòng (bảng CheckInOut, bảng PhieuXacNhanDatPhong)
--- giá thuê phòng = (đơn giá phòng * số ngày) + phí thu thêm
alter function f_TongTienThuePhong (@MaDatPhong smallint)
returns decimal(18,2) as
begin
	declare @DonGiaPhong decimal(18,2);
	declare @SoNgayThue int;
	declare @PhiThuThem decimal(18,2);
	declare @TongTienThue decimal(18,2);
	set @DonGiaPhong = (select DonGia
						from PhieuXacNhanDatPhong
						where @MaDatPhong =MaDatPhong)
	
	set @SoNgayThue = (select sum (datediff(day, NgayDatPhong, NgayTraPhong))
								from CheckInOut
								where @MaDatPhong = MaDatPhong)
	
	set @PhiThuThem = (select PhiThuThem
						from CheckInOut
						where @MaDatPhong =MaDatPhong)
	if @PhiThuThem = null
	begin
		set @TongTienThue = @DonGiaPhong * @SoNgayThue;
	end
	else
	begin
		set @TongTienThue = @DonGiaPhong * @SoNgayThue + @PhiThuThem;
	end
	return @TongTienThue
end

select dbo.f_TongTienThuePhong(1)
select dbo.f_TongTienThuePhong(2)

select * from PhieuXacNhanDatPhong
select * from CheckInOut
---- Trigger ----
--- 1. Viết trigger nhập thông tin phân quyền chỉ là duy nhất, nếu trùng thì báo lỗi
create trigger trg_KiemTraThongTinPhanQuyen_DuyNhat
on PhanQuyen
instead of INSERT, UPDATE
as
begin
	if exists (SELECT * FROM PhanQuyen WHERE TenPQ in (SELECT TenPQ from inserted))
	begin
		raiserror (N'Tên phân quyền phải là duy nhất', 16, 1)
		rollback tran
		return
	end
end

insert into PhanQuyen Values (N'Admin')
--- 2. Viết trigger kiểm tra username, passwword không được trùng, nếu trùng thì báo lỗi
create trigger trg_KiemTraThongTinDangNhap
On TaiKhoan
for insert, update as
begin
	if exists (select * from TaiKhoan
				where UserName IN (select UserName
									from inserted)
					and Passwordd IN (select Passwordd
										from inserted))
	begin
		rollback
		print N'Username, password đã tồn tại'
	end
end

insert into TaiKhoan Values (N'admin', '123456', '', '', '')
--- 3. Viết trigger kiểm tra nhập thông tin vào bảng PhieuXacNhanDatPhong, ngày đặt phòng phải nhỏ hơn ngày trả phòng
create trigger trg_KiemTraThongTinNgayDatPhong
On PhieuXacNhanDatPhong
for insert, update as
begin
	declare @ngaydatphong smalldatetime;
	declare @ngaytraphong smalldatetime;
	select @ngaytraphong = NgayTraPhong, @ngaydatphong = NgayDatPhong from inserted
	if (@ngaytraphong <= @ngaydatphong)
	begin
		rollback
		print N'Ngày trả phòng phải lớn ngày đặt phòng'
	end
end


--- 4. Viết trigger kiểm tra nhập thông tin vào bảng PhieuXacNhanDatPhong, mã đặt phòng và tên khách hàng không được để trống
create trigger trg_KiemTraThongTinNhapVao
On PhieuXacNhanDatPhong
for insert, update
as
begin
	declare @MaDatPhong smallint;
	declare @TenKH nvarchar(50);
	select @MaDatPhong = MaDatPhong, @TenKH =TenKH from inserted
	if (@MaDatPhong = null or @TenKH = null)
	begin
		rollback
		print N'Thông tin khách hàng không được để trống'
	end
end
--- 5. Viết trigger kiểm tra nhập đơn giá vào bảng PhieuXacNhanDatPhong có lớn hơn 100000 hay không.
create trigger trg_KiemTraDonGiaPhieuXacNhan
On PhieuXacNhanDatPhong
for insert, update
as
begin
	declare @DonGia decimal(18,2)
	select @DonGia = DonGia from inserted
	if (@DonGia <= 0)
	begin
		rollback
		print N'Giá phải lớn hơn 100000 đồng'
	end
end

--------------------------------------------------------------------------------------------------------
-------------------- Cấp quyền ----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
----------------- Vũ Phương An _ 19DH110766 -----------------------------------------------------------------
--- 1. Tạo các nhóm quyền thuộc CSDL QLResort tương ứng với các chức vụ như mô tả trên
--- Tạo role
create role admins
create role NhanVien
create role KhachHang
--- Tạo login
create login Admins with Password= 'admin123456'
create login NhanVien with Password= 'nv123456'
create login KhachHang with Password= 'kh123456'
--- 2. Cấp quyền cho các chức vụ trên CSDL QLResort
--- a. Admin được phép xem, chỉnh sửa, xóa tất cả dữ liệu tất các bảng của database
grant select, insert, delete, update to admins
----------------------------------------------------------------------
----------------- Lê Trương Thảo Uyên _ 19DH110822 -----------------------------------------------------------------
--- b. NhanVien được phép:
---	  Xem: trên bảng NhanVien, PhuongThucThanhToan, Phong, LoaiPhong, DonGiaPhong, DatPhong, PhieuXacNhanDatPhong, DichVu, DatDichVu, TienIchResort, DatTienIchResort. 
---   Xem, Thêm, xóa, sửa: trên bảng ThongKeDoanhThu, CheckInOut
grant select on NhanVien to NhanVien
grant select on PhuongThucThanhToan to NhanVien
grant select on Phong to NhanVien
grant select on LoaiPhong to NhanVien
grant select on DonGiaPhong to NhanVien
grant select on DatPhong to NhanVien
grant select on PhieuXacNhanDatPhong to NhanVien
grant select on DichVu to NhanVien
grant select on DatDichVu to NhanVien
grant select on TienIchResort to NhanVien
grant select on DatTienIchResort to NhanVien


grant select, insert, delete, update on ThongKeDoanhThu to NhanVien
grant select, insert, delete, update on CheckInOut to NhanVien
---------------------------------------------------------------------------------------------------------------------
----------------- Dương Thị Tuyết Như _ 19DH110140 -----------------------------------------------------------------
--- b. KhachHang được phép:
---	 Xem: trên bảng PhieuXacNhanDatPhong, PhuongThucThanhToan, DichVu, TienIch, Phong.
---  Xem, Thêm, xóa, sửa: trên bảng KhachHang, DatPhong, DatDichVu, DatTienIch.
grant select on PhuongThucThanhToan to KhachHang
grant select on Phong to KhachHang
grant select on PhieuXacNhanDatPhong to KhachHang
grant select on DichVu to KhachHang
grant select on TienIchResort to KhachHang


grant select, insert, delete, update on KhachHang to KhachHang
grant select, insert, delete, update on DatPhong to KhachHang
grant select, insert, delete, update on DatDichVu to KhachHang
grant select, insert, delete, update on DatTienIchResort to KhachHang
----------------------------------------------------------------------
----------- Thu hồi, cấm quyền ----------------------------
----------------- Lê Trương Thảo Uyên _ 19DH110822 -----------------------------------------------------------------
---- 1. Thu hồi quyền chỉnh sửa của nhân viên với thuộc tính: mã đặt phòng, tên KH, Ngày đặt phòng. (Bảng DatPhong)
REVOKE UPDATE ON DatPhong FROM NhanVien;
GRANT UPDATE(MaPhong, MaPhuongThuc, NgayTraPhong, YeucauThem) ON DatPhong TO NhanVien;
---------------------------------------------------------------------------------------------------------------------
----------------- Dương Thị Tuyết Như _ 19DH110140 -----------------------------------------------------------------
-- 2. Thu hồi quyền chỉnh sửa của khách hàng với thuộc tính : Mã phòng trong bảng Đặt Dịch Vụ
revoke update on DatDichVu to KhachHang;
grant update(MaDichVu,SoLuong) On DatDichVu to KhachHang;

-- 3. Thu hồi quyền chỉnh sửa của khách hàng với thuộc tính : Mã phòng trong bảng Đặt tiện ích resort
revoke update on DatTienIchResort to KhachHang;
grant update(MaTienIch,TenKH) On DatTienIchResort to KhachHang;

-- 4. Thu hồi quyền chỉnh sửa của khách hàng với thuộc tính : Mã khách hàng trong bảng Khách Hàng
revoke update on KhachHang to KhachHang;
grant update(HoTen,GioiTinh,SoCMND,SDT,QuocTich,NgaySinh,MaTaiKhoan,MaTaiKhoan) On KhachHang to KhachHang;
---------------------------------------------------------------------------------------------------------------------
----------------- Vũ Phương An _ 19DH110766 -----------------------------------------------------------------
---- 5. Thu hồi quyền chỉnh sửa của admin với bảng Khách hàng
revoke update on KhachHang from admins

---------------------------------------------------------------
----------- Giao tác ----------------------------
----------------- Lê Trương Thảo Uyên _ 19DH110822 -----------------------------------------------------------------
-- Cau 1. Giao tác chèn
-- T1.
CREATE PROCEDURE ThemDichVu 
@TenDV nvarchar(50),
@LoaiDV nvarchar(50)
AS
	INSERT into DichVu values (@TenDV, @LoaiDV, CAST(N'2022-11-01T00:00:00' AS SmallDateTime), CAST(N'2022-11-02T00:00:00' AS SmallDateTime))
go

BEGIN TRAN
exec ThemDichVu N'Trang trí phòng', N'Dịch Vụ Phòng'
WAITFOR DELAY '00:00:10'
COMMIT
----------- Xử lý đồng thời ----------------------------
----------------- Lê Trương Thảo Uyên _ 19DH110822 -----------------------------------------------------------------
-- Cau 2 xử lý đồng thơi
-- T1.
BEGIN TRAN
UPDATE DichVu
SET LoaiDichVu = N'Dịch Vụ chung'
WHERE MaDichVu=2
WAITFOR DELAY '00:00:10'
COMMIT
SELECT * FROM DichVu
WHERE MaDichVu=2

--T2
SET TRANSACTION ISOLATION LEVEL READ
COMMITTED
Select * from DichVu
-----------------------------------------------
-----------
-- Viết sp lấy danh sách Phòng
create proc sp_GetAllPhong
as
begin
	select *
	from Phong
end

exec sp_GetAllPhong



CREATE PROCEDURE GetDichVu
AS
	SELECT * FROM DichVu with (nolock)
go;


Create PROCEDURE ThemDichVu
@TenDichVu nvarchar(50),
@LoaiDichVu nvarchar(50),
@NgayBatDau smalldatetime,
@NgayKetThuc smalldatetime
AS
	INSERT into DichVu values (@TenDichVu, @LoaiDichVu, @NgayBatDau, @NgayKetThuc)
go;

CREATE PROCEDURE XoaDichVu
@MaDichVu smallint
AS
	Delete from DichVu where MaDichVu = @MaDichVu
go;

CREATE PROCEDURE GetPhong
AS
	SELECT * FROM Phong with (nolock)
go;



exec GetDichVu
go

--- tu day
use QLResort
go
Create PROCEDURE sp_TimKiemPhong
@GiaTri nvarchar(50),
@GiaThap decimal(16, 2),
@GiaCao decimal(16, 2)
AS
begin
	select * from Phong p, LoaiPhong lp 
	where (p.MaLoai = lp.MaLoai) and (CHARINDEX(@GiaTri, p.MoTaThongTin) > 0 or (ISNUMERIC(@GiaTri) = 1 and CAST(@GiaTri AS int)  = p.MaPhong))
			and 10 <= p.DonGia and @GiaCao >= p.DonGia and p.TrangThai = 0
end
go

exec TimKiemPhong N'101', 0, 10000000

select * from Phong p, LoaiPhong lp 
where (p.MaLoai = lp.MaLoai) and (CHARINDEX('101', p.MoTaThongTin) > 0 or (ISNUMERIC('101') = 1 and CAST('101' AS int)  = p.MaPhong))
		and 10 < p.DonGia and 1000000000 > p.DonGia and p.TrangThai = 0


go

-- Don dat phong

CREATE PROCEDURE sp_GetDonDatPhong
AS
	SELECT dp.* FROM DatPhong dp, Phong p where p.MaPhong = dp.MaPhong
go

exec GetDonDatPhong 
go


Create PROCEDURE sp_ThemDonDatPhong
@MaPhong smallint,
@MaPhuongThuc smallint,
@MaPhieuXacNhan smallint,
@TenKH nvarchar(50),
@NgayDatPhong smalldatetime,
@NgayTraPhong smalldatetime,
@YeuCauThem nvarchar(255)
AS
	begin try
		begin tran
			INSERT into DatPhong values (@MaPhong, @MaPhuongThuc, @MaPhieuXacNhan, @TenKH, @NgayDatPhong, @NgayTraPhong, @YeuCauThem)
		commit tran
	end try
	begin catch
		rollback tran
		SELECT ERROR_MESSAGE()
	end catch
go

exec sp_ThemDonDatPhong N'101', 1, NULL, N'ABC', '2022-03-29 00:00:00', '2022-03-30 00:00:00', NULL
go

Create PROCEDURE sp_SuaDonDatPhong
@MaDatPhong smallint,
@MaPhong smallint,
@MaPhuongThuc smallint,
@MaPhieuXacNhan smallint,
@TenKH nvarchar(50),
@NgayDatPhong smalldatetime,
@NgayTraPhong smalldatetime,
@YeuCauThem nvarchar(255)
AS
	begin try
		begin tran
			Update DatPhong set 
			MaPhong=@MaPhong, 
			MaPhuongThuc=@MaPhuongThuc, 
			MaPhieuXacNhan=@MaPhieuXacNhan, 
			TenKH=@TenKH, 
			NgayDatPhong=@NgayDatPhong, 
			NgayTraPhong=@NgayTraPhong, 
			YeuCauThem=@YeuCauThem	
			WHERE MaDatPhong = @MaDatPhong
		commit tran
	end try
	begin catch
		rollback tran
		SELECT ERROR_MESSAGE()
	end catch
go

exec sp_SuaDonDatPhong 33, N'101', 1, NULL, N'ABCD', '2022-03-29 00:00:00', '2022-03-30 00:00:00', N'Ví dụ'
go

Create PROCEDURE sp_XoaDonDatPhong
@MaDatPhong smallint
AS
	begin try
		begin tran
			Delete from DatPhong where MaDatPhong = @MaDatPhong
		commit tran
	end try
	begin catch
		rollback tran
		SELECT ERROR_MESSAGE()
	end catch
	
go

exec sp_XoaDonDatPhong 33
go
