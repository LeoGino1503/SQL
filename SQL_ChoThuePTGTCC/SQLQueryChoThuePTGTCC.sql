--CREATE DATABASE ChoThuePTGTCC;
USE ChoThuePTGTCC;
CREATE TABLE DANGKYCUNGCAP(
MaDKCC CHAR(5) PRIMARY KEY,
MaNhaCC CHAR(6),
MaLoaiDV CHAR(4),
DongXe CHAR(10),
MaMP CHAR(4),
NgayBatDauCungCap DATE,
NgayKetThucCungCap DATE,
SoLuongXeDangKy int);
CREATE TABLE NHACUNGCAP(
MaNhaCC CHAR(6) PRIMARY KEY,
TenNhaCC NVARCHAR(50),
DiaChi CHAR(20),
SoDT CHAR(20),
MaSoThue int);
CREATE TABLE LOAIDICHVU(
MaLoaiDV CHAR(4) PRIMARY KEY,
TenLoaiDV CHAR(50));
CREATE TABLE MUCPHI(
MaMP CHAR(4) PRIMARY KEY,
DonGia INT,
MoTa CHAR(100));
CREATE TABLE DONGXE(
DongXe CHAR(10) PRIMARY KEY,
HangXe CHAR(10),
SoChoNgoi INT);

Insert Into NHACUNGCAP ([MaNhaCC], [TenNhaCC], [DiaChi], [SoDT], [MaSoThue]) Values
('NCC001', 'Cty TNHH Toàn Phát', 'Hai Chau', '051133999888', '568941'),
('NCC002', 'Cty Cổ Phần Đông Du', 'Lien Chieu', '051133999889', '456789'),
('NCC003', 'Ông Nguyễn Văn A', 'Hoa Thuan', '051133999890', '321456'),
('NCC004', 'Cty Cổ Phần Toàn Cầu Xanh', 'Hai Chau', '05113658945', '513364'),
('NCC005', 'Cty TNHH AMA', 'Thanh Khe', '051103875466', '546546'),
('NCC006', 'Bà Trần Thị Bích Vân', 'Lien Chieu', '05113587469', '524545'),
('NCC007', 'Cty TNHH Phan Thành', 'Thanh Khe', '05113987456', '113021'),
('NCC008', 'Ông Phan Đình Nam', 'Hoa Thuan', '05113532456', '121230'),
('NCC009', 'Tập đoàn Đông Nam Á', 'Lien Chieu', '05113987121', '533654'),
('NCC010', 'Cty Cổ Phần Rạng đông', 'Lien Chieu', '05113569654', '187864');
 
 
Insert Into LOAIDICHVU ([MaLoaiDV], [TenLoaiDV]) Values 
('DV01', 'Dịch vụ xe taxi'),
('DV02', 'Dịch vụ xe buýt công cộng theo tuyến cố định'),
('DV03', 'Dịch vụ cho thuê xe theo hợp đồng');
 
Insert Into MUCPHI ([MaMP],[DonGia],[MoTa]) Values 
('MP01', '10000', 'Áp dụng từ ngày 1/2015'),
('MP02', '15000', 'Áp dụng từ ngày 2/2015'),
('MP03', '20000', 'Áp dụng từ ngày 1/2010'),
('MP04', '25000', 'Áp dụng từ ngày 2/2011');
 
Insert Into DONGXE ([DongXe],[HangXe],[SoChoNgoi]) Values 
('Hiace', 'Toyota', 16),
('Vios', 'Toyota', 5),
('Escape', 'Ford', 5),
('Cerato', 'KIA', 7),
('Forte', 'KIA', 5),
('Starex', 'Huyndai', 7),
('Grand-i10', 'Huyndai', 7);
 
Insert Into DANGKYCUNGCAP ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCungCap],[NgayKetThucCungCap],[SoLuongXeDangKy]) Values 
('DK001', 'NCC001', 'DV01', 'Hiace', 'MP01', '2015/11/20', '2016/11/20',4),
('DK002', 'NCC002', 'DV02', 'Vios', 'MP02', '2015/11/20', '2017/11/20',3),
('DK003', 'NCC003', 'DV03', 'Escape', 'MP03', '2017/11/20', '2018/11/20',5),
('DK004', 'NCC005', 'DV01', 'Cerato', 'MP04', '2015/11/20', '2019/11/20',7),
('DK005', 'NCC002', 'DV02', 'Forte', 'MP03', '2019/11/20', '2020/11/20',1),
('DK006', 'NCC004', 'DV03', 'Starex', 'MP04', '2016/11/10', '2021/11/20',2),
('DK007', 'NCC005', 'DV01', 'Cerato', 'MP03', '2015/11/30', '2016/01/25',8),
('DK008', 'NCC006', 'DV01', 'Vios', 'MP02', '2016/02/28', '2016/08/15',9),
('DK009', 'NCC005', 'DV03', 'Grand-i10', 'MP02', '2016/04/27', '2017/04/30',10),
('DK010', 'NCC006', 'DV01', 'Forte', 'MP02', '2016/11/21', '2016/02/22',4),
('DK011', 'NCC007', 'DV01', 'Forte', 'MP01', '2016/12/25', '2017/02/20',5),
('DK012', 'NCC007', 'DV03', 'Cerato', 'MP01', '2016/04/14', '2017/12/20',6),
('DK013', 'NCC003', 'DV02', 'Cerato', 'MP01', '2015/12/21', '2016/12/21',8),
('DK014', 'NCC008', 'DV02', 'Cerato', 'MP01', '2016/05/20', '2016/12/30',1),
('DK015', 'NCC003', 'DV01', 'Hiace', 'MP02', '2018/04/24', '2019/11/20',6),
('DK016', 'NCC001', 'DV03', 'Grand-i10', 'MP02', '2016/06/22', '2016/12/21',8),
('DK017', 'NCC002', 'DV03', 'Cerato', 'MP03', '2016/09/30', '2019/09/30',4),
('DK018', 'NCC008', 'DV03', 'Espace', 'MP04', '2017/12/13', '2018/09/30',2),
('DK019', 'NCC003', 'DV03', 'Espace', 'MP03', '2016/01/24', '2016/12/30',8),
('DK020', 'NCC002', 'DV03', 'Cerato', 'MP04', '2016/05/03', '2017/10/21',7),
('DK021', 'NCC006', 'DV01', 'Forte', 'MP02', '2015/01/30', '2016/12/30',9),
('DK022', 'NCC002', 'DV02', 'Cerato', 'MP04', '2016/07/25', '2017/12/30',6),
('DK023', 'NCC002', 'DV01', 'Forte', 'MP03', '2017/11/30', '2018/05/20',5),
('DK024', 'NCC003', 'DV03', 'Forte', 'MP04', '2017/12/23', '2019/11/30',8),
('DK025', 'NCC003', 'DV03', 'Hiace', 'MP02', '2016/08/24', '2017/10/25',1);
