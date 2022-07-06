CREATE DATABASE ThucTap;
USE ThucTap;
CREATE TABLE tblKhoa(
MaKhoa CHAR(10) PRIMARY KEY,
TenKhoa CHAR(30),
DienThoai CHAR(10));
CREATE TABLE tblGiangVien(
MaGV INT PRIMARY KEY,
HoTenGV CHAR(30),
Luong DECIMAL(5,2),
MaKhoa CHAR(10) REFERENCES tblKhoa);
CREATE TABLE tblSinhVien(
MaSV INT PRIMARY KEY,
HoTenSV CHAR(30),
MaKhoa CHAR(10),
NamSinh INT,
QueQuan CHAR(30));
CREATE TABLE tblDeTai(
MaDT CHAR(10) PRIMARY KEY,
TenDT CHAR(30),
KinhPhi int,
NoiThucTap char(30));
CREATE TABLE tblHuongDan(
MaSV INT PRIMARY KEY,
MaDT CHAR(10) FOREIGN KEY REFERENCES dbo.tblDeTai,
MaGV INT FOREIGN KEY REFERENCES dbo.tblGiangVien,
KetQua DECIMAL(5,2));
INSERT INTO tblKhoa VALUES
('Geo','Dia ly va QLTN',3855413),
('Math','Toan',3855411),
('Bio','Cong nghe Sinh hoc',3855412);
INSERT INTO tblGiangVien VALUES
(11,'Thanh Binh',700,'Geo'),    
(12,'Thu Huong',500,'Math'),
(13,'Chu Vinh',650,'Geo'),
(14,'Le Thi Ly',500,'Bio'),
(15,'Tran Son',900,'Math');
INSERT INTO tblSinhVien VALUES
(1,'Le Van Son','Bio',1999,'Nghe An'),
(2,'Nguyen Thi Mai','Geo',1999,'Thanh Hoa'),
(3,'Bui Xuan Duc','Math',2001,'Ha Noi'),
(4,'Nguyen Van Tung','Bio',2000,'Ha Tinh'),
(5,'Le Khanh Linh','Bio',2000,'Ha Nam'),
(6,'Tran Khac Trong','Geo',1999,'Thanh Hoa'),
(7,'Le Thi Van','Math',2000,'null'),
(8,'Hoang Van Duc','Bio',1999,'Nghe An');
INSERT INTO tblDeTai VALUES
('Dt01','GIS',100,'Nghe An'),
('Dt02','ARC GIS',500,'Nam Dinh'),
('Dt03','Spatial DB',100, 'Ha Tinh'),
('Dt04','MAP',300,'Quang Binh' );
INSERT INTO tblHuongDan VALUES
(1,'Dt01',13,8),
(2,'Dt03',14,0),
(3,'Dt03',12,10),
(5,'Dt04',14,7),
(6,'Dt01',13,Null),
(7,'Dt04',11,10),
(8,'Dt03',15,6);