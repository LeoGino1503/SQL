--Cau 1: Đưa ra thông tin gồm mã số, họ tênvà tên khoa của tất cả các giảng viên
SELECT GV.MaGV, GV.HoTenGV, K.TenKhoa
FROM tblGiangVien GV join tblKhoa K
ON GV.MaKhoa = K.MaKhoa
--Cau 2: Đưa ra thông tin gồm mã số, họ tênvà tên khoa của các giảng viên của khoa ‘DIA LY va QLTN’
SELECT GV.MaGV, GV.HoTenGV, K.TenKhoa
FROM tblGiangVien GV JOIN dbo.tblKhoa K
ON GV.MaKhoa = K.MaKhoa
WHERE K.TenKhoa='Dia ly va QLTN'
--Cau 3: Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’
SELECT COUNT(SV.MaSV) AS SoSV
FROM dbo.tblSinhVien SV
WHERE SV.MaKhoa='Bio'
--Cau 4: Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘TOAN’
SELECT SV.MaSV, SV.HoTenSV, 2022-SV.NamSinh AS TuoiSV, K.TenKhoa
FROM dbo.tblSinhVien SV JOIN dbo.tblKhoa K
ON SV.MaKhoa = K.MaKhoa
WHERE K.TenKhoa='Toan'
--Cau 5:Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’
SELECT COUNT(GV.MaGV) AS SoGV
FROM dbo.tblGiangVien GV JOIN dbo.tblKhoa K
ON GV.MaKhoa = K.MaKhoa
WHERE K.TenKhoa= 'CONG NGHE SINH HOC'
--Cau 6: Cho biết thông tin về sinh viên không tham gia thực tập
SELECT SV.MaSV,
       SV.HoTenSV,
       SV.MaKhoa,
       SV.NamSinh,
       SV.QueQuan	
FROM dbo.tblSinhVien SV
WHERE NOT EXISTS(
SELECT HD.Masv
FROM dbo.tblHuongDan HD
WHERE SV.MaSV = HD.Masv)
--Cau 7: Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
SELECT K.MaKhoa, K.TenKhoa, COUNT(K.MaKhoa) AS SoGV
FROM dbo.tblGiangVien GV JOIN dbo.tblKhoa K
ON K.MaKhoa = GV.MaKhoa
GROUP BY K.MaKhoa,K.TenKhoa
--Cau 8:Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học
SELECT K.DienThoai
FROM dbo.tblSinhVien SV JOIN dbo.tblKhoa K
ON K.MaKhoa = SV.MaKhoa
WHERE SV.HoTenSV = 'Le Van Son'