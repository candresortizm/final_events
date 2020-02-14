class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :location_type, foreign_key:true, null:false
      t.references :client, index: true, foreign_key: {to_table: :users}
      t.string :quantity, null:false

      t.timestamps
    end
  end
end
