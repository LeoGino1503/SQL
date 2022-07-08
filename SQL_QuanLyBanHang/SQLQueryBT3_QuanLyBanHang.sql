USE QuanLyBanHang
SET DATEFORMAT DMY
--Cau 1: Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT COUNT(SP.MASP) AS SoSP_TrungQuoc
FROM dbo.SANPHAM SP
WHERE SP.NUOCSX = 'Trung Quoc';

--Cau 2: Tính tổng số sản phẩm của từng nước sản xuất.
SELECT SP.NUOCSX, COUNT(SP.MASP) AS SoSP
FROM dbo.SANPHAM SP
GROUP BY SP.NUOCSX

--Cau 3: Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT SP.NUOCSX, MAX(SP.GIA), MIN(SP.GIA), AVG(SP.GIA)
FROM dbo.SANPHAM SP
GROUP BY SP.NUOCSX;

--Cau 4: Tính doanh thu bán hàng mỗi ngày.
SELECT HD.NGHD, SUM(HD.TRIGIA)
FROM dbo.HOADON HD
GROUP BY HD.NGHD;

--Cau 5: Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT SP.MASP,SP.TENSP, SUM(SL) AS SoLuong
FROM dbo.CTHD JOIN dbo.SANPHAM SP
ON SP.MASP = CTHD.MASP
JOIN dbo.HOADON HD
ON HD.SOHD = CTHD.SOHD
WHERE MONTH(HD.NGHD) = 10 AND YEAR(HD.NGHD) =2006
GROUP BY SP.MASP,SP.TENSP;

--Cau 6: Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT MONTH(HD.NGHD), SUM(HD.TRIGIA)
FROM dbo.HOADON HD
WHERE YEAR(HD.NGHD) = 2006
GROUP BY MONTH(HD.NGHD);

--Cau 7: Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
SELECT SOHD, COUNT(DISTINCT MASP) AS SP
FROM dbo.CTHD
GROUP BY SOHD
HAVING COUNT(DISTINCT MASP) > 3;

--Cau 8: Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
SELECT SOHD
FROM dbo.CTHD JOIN dbo.SANPHAM SP
ON SP.MASP = CTHD.MASP
WHERE SP.NUOCSX= 'Viet Nam'
GROUP BY SOHD
HAVING COUNT(DISTINCT CTHD.MASP) = 3;

--Cau 9: Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
SELECT TOP 1 KH.MAKH, KH.HOTEN
FROM dbo.KHACHHANG KH JOIN dbo.HOADON HD
ON HD.MAKH = KH.MAKH
GROUP BY KH.MAKH, KH.HOTEN
ORDER BY COUNT(HD.MAKH) DESC;

--Cau 10: Tháng mấy trong năm 2006, doanh số bán hàng cao nhất?
SELECT TOP 1 MONTH(HD.NGHD), SUM(HD.TRIGIA)
FROM dbo.HOADON HD
WHERE YEAR(HD.NGHD) = 2006
GROUP BY MONTH(HD.NGHD)
ORDER BY SUM(HD.TRIGIA) DESC;

--Cau 11: Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT TOP 1 SP.MASP,SP.TENSP, SL
FROM dbo.SANPHAM SP JOIN dbo.CTHD
ON CTHD.MASP = SP.MASP
ORDER BY SL ASC;

--Cau 12: Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
SELECT SP.NUOCSX,MAX(SP.MASP),MAX(SP.TENSP),MAX(SP.GIA)
FROM dbo.SANPHAM SP
GROUP BY SP.NUOCSX;

--Cau 13: Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
SELECT SP.NUOCSX
FROM dbo.SANPHAM SP
GROUP BY SP.NUOCSX
HAVING COUNT (DISTINCT SP.MASP) >=3;

--Cau14: Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
SELECT TOP 1 KH.MAKH,KH.HOTEN
FROM (	SELECT TOP 10 KH.MAKH, KH.HOTEN, COUNT(HD.MAKH) AS SL
		FROM dbo.KHACHHANG KH JOIN dbo.HOADON HD
		ON HD.MAKH = KH.MAKH
		GROUP BY KH.MAKH, KH.HOTEN, KH.DOANHSO
		ORDER BY KH.DOANHSO DESC) KH
ORDER BY SL DESC;