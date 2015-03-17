class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :email
      t.string :guid
      t.references :product, index: true
      t.string :stripe_id

      t.timestamps
    end
  end
end
