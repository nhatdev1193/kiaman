@fields = [{ field_name: 'ho', display_name: 'Họ', type: 'input', condition: %w[string = true] },
           { field_name: 'ten', display_name: 'Tên', type: 'input', condition: %w[string = true] },
           { field_name: 'sdt', display_name: 'SĐT', type: 'input', multi_condition: [%w[presence = true], %w[only_number = true]], operator: 'AND' },
           { field_name: 'sdt2', display_name: 'SĐT2', type: 'input', condition: %w[only_number = true] },
           { field_name: 'gioi_tinh', display_name: 'Giới tính', type: 'select' },
           { field_name: 'ngay_sinh', display_name: 'Ngày sinh', type: 'date', condition: %w[date > 01/01/1976] }]