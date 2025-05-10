restaurants = [
  {
    restaurant_name: '參食穗餐酒館',
    reservations: [
      {
        date: Date.today,
        time: '12:00',
        name: FFaker::NameTW.name,
        tel: FFaker::PhoneNumberTW.mobile_phone_number,
        email: FFaker::Internet.email,
        adults: rand(1..4),
      },
      {
        date: Date.today + 1.day,
        time: '18:00',
        name: FFaker::NameTW.name,
        tel: FFaker::PhoneNumberTW.mobile_phone_number,
        email: FFaker::Internet.email,
        adults: rand(1..4),
      }
    ]
  },
  {
    restaurant_name: '涮吧-燉雞鍋物',
    reservations: [
      {
        date: Date.today,
        time: '11:30',
        name: FFaker::NameTW.name,
        tel: FFaker::PhoneNumberTW.mobile_phone_number,
        email: FFaker::Internet.email,
        adults: rand(1..4),
      },
      {
        date: Date.today + 1.day,
        time: '18:00',
        name: FFaker::NameTW.name,
        tel: FFaker::PhoneNumberTW.mobile_phone_number,
        adults: rand(1..4),
      }
    ]
  },
  {
    restaurant_name: '一樂漁場',
    reservations: [
      {
        date: Date.today,
        time: '13:00',
        name: FFaker::NameTW.name,
        tel: FFaker::PhoneNumberTW.mobile_phone_number,
        email: FFaker::Internet.email,
        adults: rand(1..4),
      },
      {
        date: Date.today + 1.day,
        time: '19:00',
        name: FFaker::NameTW.name,
        tel: FFaker::PhoneNumberTW.mobile_phone_number,
        email: FFaker::Internet.email,
        adults: rand(1..4),
      }
    ]
  },
  {
    restaurant_name: '牛洞',
    reservations: [
      {
        date: Date.today,
        time: '12:00',
        name: FFaker::NameTW.name,
        tel: FFaker::PhoneNumberTW.mobile_phone_number,
        email: FFaker::Internet.email,
        adults: rand(1..4),
      },
      {
        date: Date.today + 1.day,
        time: '18:00',
        name: FFaker::NameTW.name,
        tel: FFaker::PhoneNumberTW.mobile_phone_number,
        email: FFaker::Internet.email,
        adults: rand(1..4),
      }
    ]
  }
]


restaurants.each do |item|
  restaurant = Restaurant.find_by(name: item[:restaurant_name])
  item[:reservations].each do |reservation|
    Reservation.create(reservation.merge(
      restaurant_id: restaurant.id,
      kids: 0,
      state: 'reserved',
      purpose: I18n.t('reservations.purposes').values.sample
    ))
  end
end
