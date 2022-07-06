USE ChoThuePTGTCC
--Cau 1: Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ
SELECT DX.DongXe, DX.HangXe, DX.SoChoNgoi
FROM dbo.DONGXE DX
WHERE DX.SoChoNgoi>5;

--Cau 2: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những dòng xe
--thuộc hãng xe “Toyota” với mức phí có đơn giá là 15.000 VNĐ/km hoặc những dòng xe
--thuộc hãng xe “KIA” với mức phí có đơn giá là 20.000 VNĐ/km
SELECT NCC.MaNhaCC,
       NCC.TenNhaCC,
       NCC.DiaChi,
       NCC.SoDT,
       NCC.MaSoThue
FROM dbo.NHACUNGCAP NCC JOIN dbo.DANGKYCUNGCAP DKCC
ON DKCC.MaNhaCC = NCC.MaNhaCC
JOIN dbo.DONGXE DX
ON DX.DongXe = DKCC.DongXe
JOIN dbo.MUCPHI MP
ON MP.MaMP = DKCC.MaMP
WHERE (DX.HangXe = 'Toyota' AND MP.DonGia = 15000)
OR (DX.HangXe = 'KIA' AND MP.DonGia = 20000)
GROUP BY NCC.MaNhaCC,
         NCC.TenNhaCC,
         NCC.DiaChi,
         NCC.SoDT,
         NCC.MaSoThue;

--Cau 3: Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung
--cấp và giảm dần theo mã số thuế
SELECT NCC.MaNhaCC,
       NCC.TenNhaCC,
       NCC.DiaChi,
       NCC.SoDT,
       NCC.MaSoThue
FROM dbo.NHACUNGCAP NCC
ORDER BY NCC.TenNhaCC ASC, NCC.MaSoThue DESC;

--Cau 4: Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp với
--yêu cầu chỉ đếm cho những nhà cung cấp thực hiện đăng ký cung cấp có ngày bắt đầu
--cung cấp là “20/11/2015”
SELECT DKCC.MaNhaCC, COUNT(DKCC.MaNhaCC) AS SoLanDK
FROM dbo.DANGKYCUNGCAP DKCC
WHERE DKCC.NgayBatDauCungCap = '2015-11-20'
GROUP BY DKCC.MaNhaCC;

--Cau 5: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe
--chỉ được liệt kê một lần
SELECT DX.HangXe
FROM dbo.DONGXE DX
GROUP BY Dx.HangXe;

--Cau 6: Liệt kê MaDKCC, MaNhaCC, TenNhaCC, DiaChi, MaSoThue, TenLoaiDV, DonGia,
--HangXe, NgayBatDauCC, NgayKetThucCC của tất cả các lần đăng ký cung cấp phương
--tiện với yêu cầu những nhà cung cấp nào chưa từng thực hiện đăng ký cung cấp phương
--tiện thì cũng liệt kê thông tin những nhà cung cấp đó ra
SELECT	DKCC.MaDKCC, 
		DKCC.MaNhaCC, 
		NCC.TenNhaCC, 
		NCC.DiaChi,
		NCC.MaSoThue, 
		LDV.TenLoaiDV,
		MP.DonGia,
		DX.HangXe,
		DKCC.NgayBatDauCungCap,
		DKCC.NgayKetThucCungCap
FROM dbo.DANGKYCUNGCAP DKCC 
JOIN dbo.NHACUNGCAP NCC
ON NCC.MaNhaCC = DKCC.MaNhaCC
JOIN dbo.LOAIDICHVU LDV
ON LDV.MaLoaiDV = DKCC.MaLoaiDV
JOIN dbo.MUCPHI MP
ON MP.MaMP = DKCC.MaMP
JOIN dbo.DONGXE DX
ON DX.DongXe = DKCC.DongXe;

--Câu 7: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện
--thuộc dòng xe “Hiace” hoặc từng đăng ký cung cấp phương tiện thuộc dòng xe “Cerato”
SELECT NCC.MaNhaCC,
       NCC.TenNhaCC,
       NCC.DiaChi,
       NCC.SoDT,
       NCC.MaSoThue
FROM dbo.NHACUNGCAP NCC JOIN dbo.DANGKYCUNGCAP DKCC
ON DKCC.MaNhaCC = NCC.MaNhaCC
JOIN dbo.DONGXE DX
ON DX.DongXe = DKCC.DongXe
WHERE DX.DongXe = 'Hiace' OR DX.DongXe = 'Cerato'
GROUP BY NCC.MaNhaCC,
       NCC.TenNhaCC,
       NCC.DiaChi,
       NCC.SoDT,
       NCC.MaSoThue;

--Cau 8: Liệt kê thông tin của các nhà cung cấp chưa từng thực hiện đăng ký cung cấp
--phương tiện lần nào cả.
SELECT NCC.MaNhaCC,
       NCC.TenNhaCC,
       NCC.DiaChi,
       NCC.SoDT,
       NCC.MaSoThue
FROM dbo.NHACUNGCAP NCC
WHERE NOT EXISTS(
SELECT DKCC.MaNhaCC
FROM dbo.DANGKYCUNGCAP DKCC
WHERE NCC.MaNhaCC=DKCC.MaNhaCC);