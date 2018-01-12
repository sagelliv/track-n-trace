FactoryBot.define do
  factory :user do
    name  { Faker::Name.name }
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
  end

  factory :booking do
    bl_number 'TXG790195200'
    steamship_line 'pil'
    origin 'Xingang'
    destination 'Oakland'
    vessel 'CSCL AUTUMN'
    voyage 'VQC60007E'
    vessel_eta Date.new(2017, 4, 19)
  end

  factory :booking_event do
    booking

    bl_number 'TXG790195200'
    steamship_line 'pil'
    origin 'Xingang'
    destination 'Oakland'
    vessel 'CSCL AUTUMN'
    voyage 'VQC60007E'
    vessel_eta Date.new(2017, 4, 19)
    event_changes 'No changes'
  end

  factory :booking_interest do
    user
    booking
    watch false
  end

  factory :container do
    number { Faker::Number.number(8) }
    size "20'"
    container_type 'GP'
  end
end
