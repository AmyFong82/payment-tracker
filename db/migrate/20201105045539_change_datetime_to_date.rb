class ChangeDatetimeToDate < ActiveRecord::Migration[6.0]
  def change
  	change_column :bills, :due_date, :date
  end
end
