class AddBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.string :bl_number, null: false
      t.string :steamship_line, null: false
      t.string :origin, null: false
      t.string :destination, null: false
      t.string :vessel, null: false
      t.string :voyage, null: false
      t.datetime :vessel_eta, null: false

      t.timestamps
    end

    create_table :booking_events do |t|
      t.belongs_to :booking, index: true

      t.string :bl_number, null: false
      t.string :steamship_line, null: false
      t.string :origin, null: false
      t.string :destination, null: false
      t.string :vessel, null: false
      t.string :voyage, null: false
      t.datetime :vessel_eta, null: false

      t.string :event_changes

      t.timestamps
    end

    create_table :containers do |t|
      t.belongs_to :booking, index: true
      t.belongs_to :booking_event, index: true

      t.string :number, null: false
      t.string :size,   null: false
      t.string :type,   null: false

      t.timestamps
    end
  end
end
