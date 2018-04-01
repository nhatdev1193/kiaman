@fields = [{ field_name: 'sdt2', display_name: 'SĐT2', type: 'input' },
           { field_name: 'so_passport', display_name: 'Số Passport', type: 'input' },
           { field_name: 'ngay_cap_cmnd', display_name: 'Ngày cấp', type: 'date', condition: %w[date > 01/01/1976] },
           { field_name: 'ngay_cap_passport', display_name: 'Ngày cấp', type: 'date', condition: %w[date > 01/01/1976] },
           { field_name: 'noi_cap_cmnd', display_name: 'Nơi cấp', type: 'input' },
           { field_name: 'noi_cap_passport', display_name: 'Nơi cấp', type: 'input' },
           # Thong tin noi o
           { field_name: 'dia_chi_ho_khau', display_name: 'Hộ khẩu (số nhà, đường)', type: 'input', condition: %w[presence = true] },
           { field_name: 'tinh_tp_ho_khau', display_name: 'TP/ Tỉnh', type: 'select' },
           { field_name: 'quan_huyen_ho_khau', display_name: 'Quận/ Huyện', type: 'select' },
           { field_name: 'phuong_xa_ho_khau', display_name: 'Phường/ Xã', type: 'select' },
           { field_name: 'dia_chi_hien_tai', display_name: 'Nơi ở hiện tại', type: 'input' },
           { field_name: 'tinh_tp_hien_tai', display_name: 'TP/ Tỉnh', type: 'select' },
           { field_name: 'quan_huyen_hien_tai', display_name: 'Quận/ Huyện', type: 'select' },
           { field_name: 'phuong_xa_hien_tai', display_name: 'Phường/ Xã', type: 'select' },
           { field_name: 'tinh_trang_nha_o', display_name: 'Tình trạng nhà ở', type: 'select' },
           { field_name: 'ten_chu_nha', display_name: 'Tên chủ nhà', type: 'input' },
           { field_name: 'sdt_chu_nha', display_name: 'Điện thoại chủ nhà', type: 'input' },
           { field_name: 'so_nam_o_tp_hien_tai', display_name: 'Số năm ở TP/ tỉnh hiện tại', type: 'input' },
           { field_name: 'so_nam_o_nha_hien_tai', display_name: 'Số năm ở nhà hiện tại', type: 'input' },
           { field_name: 'o_voi_ai', display_name: 'Ở với ai?', type: 'input' },
           # Thong tin khac
           { field_name: 'trinh_do_hoc_van', display_name: 'Trình độ học vấn', type: 'select' },
           { field_name: 'tinh_trang_hon_nhan', display_name: 'Tình trạng hôn nhân', type: 'select' },
           { field_name: 'so_nguoi_phu_thuoc', display_name: 'Số người phụ thuộc', type: 'select' },
           { field_name: 'so_con', display_name: 'Số con', type: 'select' },
           { field_name: 'tuoi_con_lon_nhat', display_name: 'Tuổi con lớn nhất', type: 'input' },
           { field_name: 'tuoi_con_nho_nhat', display_name: 'Tuổi con nhỏ nhất', type: 'input' },
           { field_name: 'email', display_name: 'Email', type: 'input' },
           { field_name: 'facebook', display_name: 'Facebook', type: 'input' },
           { field_name: 'zalo', display_name: 'Zalo', type: 'input' },

           # Tai chinh
           { field_name: 'ten_ngan_hang', display_name: 'Tên ngân hàng', type: 'input' },
           { field_name: 'so_tk', display_name: 'Số tài khoản', type: 'input' },
           { field_name: 'so_the', display_name: 'Số thẻ', type: 'input' },
           { field_name: 'chu_tai_khoan', display_name: 'Chủ tài khoản', type: 'input' },
           { field_name: 'tinh_tp_tk_ngan_hang', display_name: 'Tỉnh/TP', type: 'select' },
           { field_name: 'chi_nhanh_mo', display_name: 'Chi nhánh mở', type: 'input' },

           # To chuc tin dung 1
           { field_name: 'ten_tctd_1', display_name: 'Tên TCTD', type: 'input' },
           { field_name: 'thoi_han_tctd_1', display_name: 'Thời hạn', type: 'input' },
           { field_name: 'so_tien_vay_tctd_1', display_name: 'Số tiền vay', type: 'input' },
           { field_name: 'so_du_no_tctd_1', display_name: 'Số dư nợ', type: 'input' },
           { field_name: 'so_tien_tra_hang_thang_tctd_1', display_name: 'Số tiền trả hằng tháng', type: 'input' },
           { field_name: 'so_thang_con_lai_tctd_1', display_name: 'Số tháng còn lại', type: 'input' },
           { field_name: 'ghi_chu_tctd_1', display_name: 'Ghi chú', type: 'input' },

           # To chuc tin dung 2
           { field_name: 'ten_tctd_2', display_name: 'Tên TCTD', type: 'input' },
           { field_name: 'thoi_han_tctd_2', display_name: 'Thời hạn', type: 'input' },
           { field_name: 'so_tien_vay_tctd_2', display_name: 'Số tiền vay', type: 'input' },
           { field_name: 'so_du_no_tctd_2', display_name: 'Số dư nợ', type: 'input' },
           { field_name: 'so_tien_tra_hang_thang_tctd_2', display_name: 'Số tiền trả hằng tháng', type: 'input' },
           { field_name: 'so_thang_con_lai_tctd_2', display_name: 'Số tháng còn lại', type: 'input' },
           { field_name: 'ghi_chu_tctd_2', display_name: 'Ghi chú', type: 'input' },

           # To chuc tin dung 3
           { field_name: 'ten_tctd_3', display_name: 'Tên TCTD', type: 'input' },
           { field_name: 'thoi_han_tctd_3', display_name: 'Thời hạn', type: 'input' },
           { field_name: 'so_tien_vay_tctd_3', display_name: 'Số tiền vay', type: 'input' },
           { field_name: 'so_du_no_tctd_3', display_name: 'Số dư nợ', type: 'input' },
           { field_name: 'so_tien_tra_hang_thang_tctd_3', display_name: 'Số tiền trả hằng tháng', type: 'input' },
           { field_name: 'so_thang_con_lai_tctd_3', display_name: 'Số tháng còn lại', type: 'input' },
           { field_name: 'ghi_chu_tctd_3', display_name: 'Ghi chú', type: 'input' },

           # To chuc tin dung 4
           { field_name: 'ten_tctd_4', display_name: 'Tên TCTD', type: 'input' },
           { field_name: 'thoi_han_tctd_4', display_name: 'Thời hạn', type: 'input' },
           { field_name: 'so_tien_vay_tctd_4', display_name: 'Số tiền vay', type: 'input' },
           { field_name: 'so_du_no_tctd_4', display_name: 'Số dư nợ', type: 'input' },
           { field_name: 'so_tien_tra_hang_thang_tctd_4', display_name: 'Số tiền trả hằng tháng', type: 'input' },
           { field_name: 'so_thang_con_lai_tctd_4', display_name: 'Số tháng còn lại', type: 'input' },
           { field_name: 'ghi_chu_tctd_4', display_name: 'Ghi chú', type: 'input' },

           # To chuc tin dung 5
           { field_name: 'ten_tctd_5', display_name: 'Tên TCTD', type: 'input' },
           { field_name: 'thoi_han_tctd_5', display_name: 'Thời hạn', type: 'input' },
           { field_name: 'so_tien_vay_tctd_5', display_name: 'Số tiền vay', type: 'input' },
           { field_name: 'so_du_no_tctd_5', display_name: 'Số dư nợ', type: 'input' },
           { field_name: 'so_tien_tra_hang_thang_tctd_5', display_name: 'Số tiền trả hằng tháng', type: 'input' },
           { field_name: 'so_thang_con_lai_tctd_5', display_name: 'Số tháng còn lại', type: 'input' },
           { field_name: 'ghi_chu_tctd_5', display_name: 'Ghi chú', type: 'input' },

           # Viec lam
           { field_name: 'chuc_vu', display_name: 'Chức vụ', type: 'input' },
           { field_name: 'cong_ty', display_name: 'Công ty', type: 'input' },
           { field_name: 'dia_chi_cong_ty', display_name: 'Địa chỉ', type: 'input' },
           { field_name: 'tinh_trang_lam_viec', display_name: 'Tình trạng làm việc', type: 'select' },
           { field_name: 'so_thang_lam_viec', display_name: 'Số tháng làm việc', type: 'input' },
           { field_name: 'nguoi_xac_nhan', display_name: 'Người xác nhận', type: 'input' },
           { field_name: 'vi_tri_xac_nhan', display_name: 'Vị trí xác nhận', type: 'input' },
           { field_name: 'sdt_nguoi_xac_nhan', display_name: 'Số điện thoại người xác nhận', type: 'input' },
           { field_name: 'ky_thu_nhap', display_name: 'Kỳ thu nhập', type: 'select' },
           { field_name: 'thu_nhap_trung_binh_ky', display_name: 'Thu nhập trung bình/kỳ', type: 'input' },
           { field_name: 'ngay_tra_luong', display_name: 'Ngày trả lương', type: 'input' }
]

@business_fields = [
    { field_name: 'ma_kd', display_name: 'Mã KD', type: 'input' },
    { field_name: 'thoi_gian_kinh_doanh', display_name: 'Thời gian kinh doanh', type: 'input' },
    { field_name: 'so_nam_kinh_doanh', display_name: 'Số năm kinh doanh', type: 'input' },
    { field_name: 'so_nam_kd_tai_mat_bang', display_name: 'Số năm KD tại mặt bằng', type: 'input' },
    { field_name: 'so_nhan_vien', display_name: 'Số nhân viên', type: 'input' },
    { field_name: 'hinh_thuc_kinh_doanh', display_name: 'Hình thức kinh doanh', type: 'select' },
    { field_name: 'hinh_thuc_kinh_doanh_khac', display_name: '', type: 'input' },
    { field_name: 'loai_mat_bang', display_name: 'Loại mặt bằng', type: 'select' },
    { field_name: 'loai_mat_bang_khac', display_name: '', type: 'input' },
    { field_name: 'so_nha_dia_chi_kd', display_name: 'Địa chỉ KD (số nhà)', type: 'input' },
    { field_name: 'tinh_tp_dia_chi_kd', display_name: 'TP/Tỉnh', type: 'input' },
    { field_name: 'quan_huyen_dia_chi_kd', display_name: 'Quận/Huyện', type: 'input' },
    { field_name: 'phuong_xa_dia_chi_kd', display_name: 'Phường/Xã', type: 'input' },
    { field_name: 'dien_tich_mat_bang', display_name: 'Diện tích mặt bằng', type: 'input' },
    { field_name: 'so_huu', display_name: 'Sở hữu', type: 'select' },
    { field_name: 'thoi_gian_thue_tu', display_name: 'Thời gian thuê', type: 'date' },
    { field_name: 'thoi_gian_thue_den', display_name: 'Thời gian thuê', type: 'date' },
    { field_name: 'ma_so_thue', display_name: 'Mã số thuế', type: 'input' },
    { field_name: 'ma_so_doanh_nghiep', display_name: 'Mã số doanh nghiệp', type: 'input' }
]

@study_fields = [
    { field_name: 'sinh_vien_nam', display_name: 'Sinh viên năm', type: 'select' },
    { field_name: 'nien_khoa', display_name: 'Niên khoá', type: 'input' },
    { field_name: 'nganh_hoc', display_name: 'Ngành học', type: 'input' },
    { field_name: 'mssv', display_name: 'MSSV', type: 'input' },
    { field_name: 'lop', display_name: 'Lớp', type: 'input' },
    { field_name: 'diem_hoc_tap', display_name: 'Điểm học tập', type: 'input' },
    { field_name: 'xep_loai', display_name: 'Xếp loại', type: 'select' },
    { field_name: 'web_xem_diem', display_name: 'Website xem điểm', type: 'input' },
    { field_name: 'username', display_name: 'Username', type: 'input' },
    { field_name: 'passcode', display_name: 'Passcode', type: 'input' }
]