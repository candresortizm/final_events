class CreateLocationTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :location_types do |t|
      t.references :sale_event, null: false, foreign_key: true
      t.string :name, null: false
      t.decimal :price, null: false
      t.decimal :quantity, null: false

      t.timestamps
    end
  end
end
