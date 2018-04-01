class FormField < ApplicationRecord
  belongs_to :form
  belongs_to :form_input
  belongs_to :condition_group, optional: true
  belongs_to :form_object, optional: true
  has_many :form_values

  attr_accessor :field_value

  INSTITUTION_FIELDS = %w[ ten_tctd thoi_han_tctd so_tien_vay_tctd
                            so_du_no_tctd so_tien_tra_hang_thang_tctd
                            so_thang_con_lai_tctd ghi_chu_tctd ].freeze
end