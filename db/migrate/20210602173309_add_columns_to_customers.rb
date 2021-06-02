class AddColumnsToCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :address, :street_address
    add_column :customers, :city, :string
    add_column :customers, :state, :string
    add_column :customers, :zipcode, :string
  end
end
