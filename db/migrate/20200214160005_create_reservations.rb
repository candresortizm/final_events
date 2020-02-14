class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :location_type, foreign_key:true, null:false
      t.references :user, foreign_key: true
      t.string :quantity, null:false

      t.timestamps
    end
  end
end
