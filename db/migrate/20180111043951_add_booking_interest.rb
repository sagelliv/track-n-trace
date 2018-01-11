class AddBookingInterest < ActiveRecord::Migration[5.1]
  def change
    create_table :booking_interests do |t|
      t.belongs_to :booking
      t.belongs_to :user

      t.boolean :watch

      t.timestamps
    end
  end
end
