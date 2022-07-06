--Cau 1: Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn
SELECT DT.MaDT, DT.TenDT
FROM dbo.tblGiangVien GV JOIN dbo.tblHuongDan HD
ON GV.MaGV = HD.MaGV
JOIN dbo.tblDeTai DT
ON DT.MaDT = HD.MaDT
WHERE GV.HoTenGV = 'Tran Son'
--Cau 2: Cho biết tên đề tài không có sinh viên nào thực tập
SELECT DT.MaDT, DT.TenDT
FROM dbo.tblDeTai DT
WHERE NOT EXISTS(
SELECT HD.MaDT
FROM dbo.tblHuongDan HD
WHERE HD.MaDT= DT.MaDT)
--Cau 3: Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn 2 sinh viên
SELECT GV.MaGV, GV.HoTenGV, K.TenKhoa
FROM dbo.tblGiangVien GV JOIN dbo.tblKhoa K
ON K.MaKhoa = GV.MaKhoa
WHERE GV.MaGV IN(
SELECT HD.MaGV
FROM dbo.tblHuongDan HD
GROUP BY HD.MaGV
HAVING COUNT (HD.MaSV)=2)
--Cau 4: Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
SELECT DT.MaDT, DT.TenDT, DT.KinhPhi
FROM dbo.tblDeTai DT 
WHERE DT.KinhPhi = (
SELECT MAX (DT.KinhPhi)
FROM dbo.tblDeTai DT)
--Cau 5: Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
SELECT DT.MaDT, DT.TenDT
FROM dbo.tblDeTai DT
WHERE DT.MaDT IN (
SELECT HD.MaDT
FROM dbo.tblHuongDan HD
GROUP BY HD.MaDT
HAVING COUNT (HD.MaDT)>2)
--Cau 6: Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’
SELECT SV.MaSV, SV.HoTenSV, HD.KetQua
FROM dbo.tblSinhVien SV JOIN dbo.tblHuongDan HD
ON HD.MaSV = SV.MaSV
JOIN dbo.tblKhoa K
ON K.MaKhoa = SV.MaKhoa
WHERE K.TenKhoa = 'Dia ly va QLTN'
--Cau 7: Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
SELECT K.TenKhoa, Count (SV.MaKhoa) AS SoSV
FROM dbo.tblKhoa K JOIN dbo.tblSinhVien SV
ON SV.MaKhoa = K.MaKhoa
GROUP BY K.TenKhoa
--Cau 8: Cho biết thông tin về các sinh viên thực tập tại quê nhà
SELECT SV.MaSV,
       SV.HoTenSV,
       SV.MaKhoa,
       SV.NamSinh,
       SV.QueQuan
FROM dbo.tblSinhVien SV JOIN dbo.tblHuongDan HD
ON HD.MaSV = SV.MaSV
JOIN dbo.tblDeTai DT
ON DT.MaDT = HD.MaDT
WHERE SV.QueQuan = DT.NoiThucTap
--Cau 9: Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
SELECT SV.MaSV,
       SV.HoTenSV,
       SV.MaKhoa
FROM dbo.tblSinhVien SV JOIN dbo.tblHuongDan HD
ON HD.MaSV = SV.MaSV
WHERE HD.KetQua IS NULL
--Cau 10: Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0
SELECT SV.MaSV,
       SV.HoTenSV
FROM dbo.tblSinhVien SV JOIN dbo.tblHuongDan HD
ON HD.MaSV = SV.MaSV
WHERE HD.KetQua = 0