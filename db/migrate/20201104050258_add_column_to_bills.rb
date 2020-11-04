class AddColumnToBills < ActiveRecord::Migration[6.0]
  def change
  	add_column :bills, :recurrence, :string
  end
end
