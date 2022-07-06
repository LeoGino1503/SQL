USE QuanLyBanHang
set dateformat DMY
--Cau 1: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
SELECT SP.MASP, SP.TENSP, SP.NUOCSX
FROM dbo.SANPHAM SP
WHERE SP.NUOCSX = 'Trung Quoc';

--Cau 2: In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
SELECT SP.MASP, SP.TENSP, SP.DVT
FROM dbo.SANPHAM SP
WHERE SP.DVT = 'cay' OR SP.DVT = 'quyen';

--Cau 3: In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
SELECT SP.MASP, SP.TENSP
FROM dbo.SANPHAM SP
WHERE SP.MASP like 'B%01';
--Cau 4: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
SELECT SP.MASP, SP.TENSP, SP.NUOCSX, SP.GIA
FROM dbo.SANPHAM SP
WHERE SP.NUOCSX = 'Trung Quoc' AND SP.GIA >=30000 AND SP.GIA <40000;

--Cau 5: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
SELECT SP.MASP, SP.TENSP, SP.NUOCSX, SP.GIA
FROM dbo.SANPHAM SP
WHERE SP.NUOCSX = 'Trung Quoc' AND SP.GIA >=30000 AND SP.GIA <=40000
OR SP.NUOCSX = 'Thai Lan' AND SP.GIA >=30000 AND SP.GIA <=40000;

--Cau 6: In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT HD.SOHD, HD.TRIGIA, HD.NGHD
FROM dbo.HOADON HD
WHERE HD.NGHD = '1/1/2007' OR  HD.NGHD= '2/1/2007';

--Cau 7: In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT HD.SOHD, HD.TRIGIA, HD.NGHD
FROM dbo.HOADON HD
WHERE HD.NGHD >= '1/1/2007' AND HD.NGHD <='31/1/2007'
ORDER BY HD.TRIGIA DESC, HD.NGHD ASC;

--Cau 8: In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT KH.MAKH, KH.HOTEN, HD.NGHD
FROM dbo.KHACHHANG KH JOIN dbo.HOADON HD
ON HD.MAKH = KH.MAKH
WHERE HD.NGHD = '1/1/2007';

--Cau 9: In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
SELECT HD.SOHD, HD.TRIGIA, NV.HOTEN, HD.NGHD
FROM dbo.HOADON HD JOIN dbo.NHANVIEN NV
ON NV.MANV = HD.MANV
WHERE NV.HOTEN = 'Nguyen Van B' AND HD.NGHD = '28/10/2006';

--Cau 10: In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
SELECT SP.MASP, SP.TENSP, KH.HOTEN, HD.NGHD
FROM dbo.SANPHAM SP JOIN dbo.CTHD ON CTHD.MASP = SP.MASP
JOIN dbo.HOADON HD ON HD.SOHD = CTHD.SOHD
JOIN dbo.KHACHHANG KH ON KH.MAKH = HD.MAKH
WHERE KH.HOTEN = 'Nguyen Van A' AND '1/10/2006' <= HD.NGHD AND HD.NGHD <= '31/10/2006';

--Cau 11: Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
SELECT SOHD, CTHD.MASP
FROM dbo.CTHD
WHERE CTHD.MASP = 'BB01' OR CTHD.MASP = 'BB02';

--Cau 12: Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD, MASP, SL
FROM dbo.CTHD
WHERE MASP = 'BB01' AND SL >=10 AND SL<=20
OR MASP = 'BB02' AND SL >=10 AND SL<=20;

--Cau 13: Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20
SELECT CT1.SOHD
FROM dbo.CTHD CT1
WHERE MASP = 'BB02' AND SL <=20 AND SL>=10 AND EXISTS(
SELECT CT2.SOHD
FROM dbo.CTHD CT2
WHERE MASP = 'BB01' AND CT1.SOHD= CT2.SOHD AND SL <=20 AND SL>=10);

--Cau 14: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT SP.MASP, SP.TENSP, SP.NUOCSX, HD.NGHD
FROM dbo.SANPHAM SP JOIN dbo.CTHD
ON CTHD.MASP = SP.MASP
JOIN dbo.HOADON HD
ON HD.SOHD = CTHD.SOHD
WHERE SP.NUOCSX='Trung Quoc' OR HD.NGHD='1/1/2007';

--Cau 15: In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT SP.MASP, SP.TENSP
FROM dbo.SANPHAM SP
WHERE NOT EXISTS(
SELECT MASP
FROM dbo.CTHD
WHERE SP.MASP=MASP);