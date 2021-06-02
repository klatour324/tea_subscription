class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :tea, null: false, foreign_key: true
      t.string :title
      t.float :price
      t.boolean :status, default: true
      t.string :frequency

      t.timestamps
    end
  end
end
