class CreateBills < ActiveRecord::Migration[6.0]
  def change
  	create_table :bills do |t|
  		t.string :company_name
  		t.datetime :due_date
  		t.float :amount
  		t.boolean :paid
  		t.integer :user_id
  	end
  end
end
