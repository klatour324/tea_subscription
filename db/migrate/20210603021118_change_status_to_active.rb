class ChangeStatusToActive < ActiveRecord::Migration[6.1]
  def change
    rename_column :subscriptions, :status, :active
  end
end
