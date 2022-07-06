USE QuanLyBanHang
SET DATEFORMAT DMY
--Cau 1: In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT SP.MASP,SP.TENSP
FROM dbo.SANPHAM SP
WHERE NOT EXISTS(
SELECT MASP
FROM dbo.CTHD JOIN dbo.HOADON HD
ON HD.SOHD = CTHD.SOHD
WHERE MASP=SP.MASP AND YEAR(HD.NGHD)=2006);

--Cau 2: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
SELECT SP.MASP,SP.TENSP
FROM dbo.SANPHAM SP
WHERE SP.NUOCSX ='Trung Quoc' AND NOT EXISTS(
SELECT MASP
FROM dbo.CTHD JOIN dbo.HOADON HD
ON HD.SOHD = CTHD.SOHD
WHERE MASP=SP.MASP AND YEAR(HD.NGHD)=2006);

--Cau 3: Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
SELECT SOHD, SP.NUOCSX
FROM dbo.CTHD JOIN dbo.SANPHAM SP
ON SP.MASP = CTHD.MASP
WHERE SP.NUOCSX = 'Singapore';

--Cau 4: Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(HD.SOHD) AS SoHDKTV
FROM dbo.HOADON HD
WHERE NOT EXISTS(
SELECT KH.MAKH
FROM dbo.KHACHHANG KH
WHERE KH.MAKH=HD.MAKH);

--Cau 5: Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT COUNT(DISTINCT SP.MASP) AS SoSP 
FROM dbo.SANPHAM SP JOIN dbo.CTHD 
ON CTHD.MASP = SP.MASP
JOIN dbo.HOADON HD
ON HD.SOHD = CTHD.SOHD
WHERE CTHD.MASP=SP.MASP AND YEAR(HD.NGHD) = 2006;

--Cau 6: Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
SELECT MAX(HD.TRIGIA) AS TGHDCN, MIN(HD.TRIGIA) AS TGHDTN
FROM dbo.HOADON HD;

--Cau 7: Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(HD.TRIGIA) AS TGTB2006
FROM dbo.HOADON HD
WHERE YEAR(HD.NGHD) = 2006;

--Cau 8: Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(HD.TRIGIA) AS DoanhThu
FROM dbo.HOADON HD
WHERE YEAR(HD.NGHD) = 2006;

--Cau 9: Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT HD.SOHD 
FROM dbo.HOADON HD
WHERE HD.TRIGIA = (
SELECT MAX(HD.TRIGIA)
FROM dbo.HOADON HD) AND YEAR(HD.NGHD)=2006;

--Cau 10: Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT KH.HOTEN
FROM dbo.KHACHHANG KH JOIN dbo.HOADON HD
ON HD.MAKH = KH.MAKH
WHERE HD.TRIGIA = (
SELECT MAX(HD.TRIGIA)
FROM dbo.HOADON HD) AND YEAR(HD.NGHD)=2006;

--Cau 11: In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
SELECT TOP 3 KH.MAKH, KH.HOTEN, KH.DOANHSO
FROM dbo.KHACHHANG KH
ORDER BY KH.DOANHSO DESC;

--Cau 12: In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT SP.MASP,SP.TENSP, SP.GIA
FROM dbo.SANPHAM SP
WHERE SP.GIA IN (
SELECT TOP 3 SP.GIA
FROM dbo.SANPHAM SP
ORDER BY SP.GIA DESC);

--Cau 13: In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
SELECT SP.MASP,SP.TENSP,SP.NUOCSX,SP.GIA
FROM dbo.SANPHAM SP
WHERE SP.NUOCSX='Thai Lan' AND SP.GIA IN (
SELECT TOP 3 SP.GIA
FROM dbo.SANPHAM SP
ORDER BY SP.GIA DESC);

--Cau 14: In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
SELECT SP.MASP,SP.TENSP,SP.NUOCSX,SP.GIA
FROM dbo.SANPHAM SP
WHERE SP.NUOCSX='Trung Quoc' AND SP.GIA IN (
SELECT TOP 3 SP.GIA
FROM dbo.SANPHAM SP
WHERE SP.NUOCSX ='Trung Quoc'
ORDER BY SP.GIA DESC);
