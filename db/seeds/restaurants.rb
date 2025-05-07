restaurants = [
  {
    name: '參食穗餐酒館',
    url: 'sanshisui',
    tel: '02-2545-0310',
    address: '105台北市松山區敦化北路120巷16號1樓',
    description: '「叁食穗餐酒館」位於捷運南京復興站與小巨蛋中間，由來自五星級主廚以獨特的新中式BISTRO顛覆大眾對中菜印象，不論經典老菜及創意新作都能吃出時尚美味。',
    mealtime: 60,
    bookday_advance: 14
  }
]


restaurants.each do |restaurant|
  Restaurant.create!(restaurant)
end
