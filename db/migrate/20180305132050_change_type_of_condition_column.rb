class ChangeTypeOfConditionColumn < ActiveRecord::Migration[5.1]
  def change
    change_column :conditions, :condition, 'json USING CAST(condition AS json)'
  end
end
