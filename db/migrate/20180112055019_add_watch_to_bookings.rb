class AddWatchToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :watch, :string
  end
end
