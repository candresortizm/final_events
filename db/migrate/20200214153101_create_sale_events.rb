class CreateSaleEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :sale_events do |t|
      t.string :title, null: false
      t.string :description
      t.string :image, null: false
      t.string :place
      t.datetime :event_date, null: false
      t.references :owner, index: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
