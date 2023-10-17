FactoryBot.define do
  factory :order_address do
    postal_code   { '123-4567' }
    prefecture_id { 5 }
    municipality  { '東京都' }
    block         { '1-1' }
    building_name { '浅草ビル' }
    phone_number  { 12345678901 }
    token         { 'tok_abcdefghijk00000000000000000' }
  end
end
