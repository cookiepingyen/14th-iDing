restaurants = [
  {
    name: '參食穗餐酒館',
    url: 'sanshisui',
    tel: '02-2545-0310',
    address: '105台北市松山區敦化北路120巷16號1樓',
    description: '「叁食穗餐酒館」位於捷運南京復興站與小巨蛋中間，由來自五星級主廚以獨特的新中式BISTRO顛覆大眾對中菜印象，不論經典老菜及創意新作都能吃出時尚美味。',
    mealtime: 60,
    bookday_advance: 14,
    user_email: 'idingdemo@gmail.com',
    image: 'app/assets/images/restaurants/sanshisui/30SUI.png',
    menus: [
      'app/assets/images/restaurants/sanshisui/30SUI_menu1.png',
      'app/assets/images/restaurants/sanshisui/30SUI_menu2.png',
    ],
    holidays: %w[Mon],
    open_times: [
      { start_time: '11:30', end_time: '22:00' }
    ]
  },
  {
    name: '涮吧-燉雞鍋物',
    url: 'shaba',
    tel: '02-2244-7486',
    address: '235新北市中和區圓通路287號',
    description: <<~DESC,
      【炸香蒜蛤蜊燉雞湯】是紅牌
      【水月水果枝仔冰】夏季熱映中
      -
      ｜採用全雞、高麗菜、洋蔥、西芹熬製的好湯｜
      -
      個人燉雞鍋物
      營業中｜11:30-22:00
      中和店｜圓通路287號（雙和醫院旁）
      訂位先｜02-22447486
      -
    DESC
    mealtime: 60,
    bookday_advance: 14,
    user_email: 'idingdemo@gmail.com',
    image: 'app/assets/images/restaurants/shaba/shaba.png',
    menus: [
      'app/assets/images/restaurants/shaba/shaba_menu.png',
    ],
    open_times: [
      { start_time: '11:30', end_time: '21:00' }
    ]
  },
  {
    name: '一樂漁場',
    url: 'lchiraku_fishery',
    tel: '02-2233-1916',
    address: '234新北市永和區得和路131號',
    description: <<~DESC,
      永和在地生魚片小店，無預約服務需現場候位。
      以供應新鮮美味海鮮丼飯為主，也提供熟食丼飯及茶碗蒸、季節性限定丼飯。

      不提供訂位/ 請現場候位
      永安市場🚇 約10-15分鐘
      秀朗樂活🅿️ 約5分鐘
      供餐時間 11:30 - 13:30、17:30 - 20:30每週一公休
      外帶請先訂餐避免久候 Line 線上點餐
    DESC
    mealtime: 60,
    bookday_advance: 14,
    user_email: 'ilikefood@gmail.com',
    image: 'app/assets/images/restaurants/lchiraku_fishery/lchiraku_fishery.png',
    menus: [
      'app/assets/images/restaurants/lchiraku_fishery/lchiraku_fishery_menu1.png',
      'app/assets/images/restaurants/lchiraku_fishery/lchiraku_fishery_menu2.png',
    ],
    holidays: %w[Mon],
    open_times: [
      { start_time: '11:30', end_time: '13:30' },
      { start_time: '17:30', end_time: '20:30' }
    ]
  },
  {
    name: '牛洞',
    url: 'neo_don',
    tel: '02-2930-0088',
    address: '116台北市文山區羅斯福路五段198號',
    description: <<~DESC,
      專營創意日式丼飯專門店,秉持日本職人精神,用心經營台灣在地品牌即將邁入第十一年
      #安心美味是我們不變的堅持
      【牛】腳踏實地 提供安心,美味的料理
      【洞】早期人類以洞穴為家，傳遞溫暖慈愛與力量。幸福的味道
    DESC
    mealtime: 60,
    bookday_advance: 14,
    user_email: 'ilikefood@gmail.com',
    image: 'app/assets/images/restaurants/neo_don/neo_don.png',
    menus: [
      'app/assets/images/restaurants/neo_don/neo_don_menu.png',
    ],
    open_times: [
      { start_time: '11:00', end_time: '14:00' },
      { start_time: '17:00', end_time: '20:30' }
    ]
  }
]

restaurants.each do |item|
  restaurant = Restaurant.find_by(name: item[:name])
  if restaurant.blank?
    restaurant = Restaurant.new(
      name: item[:name],
      url: item[:url],
      tel: item[:tel],
      address: item[:address],
      description: item[:description],
      mealtime: item[:mealtime],
      bookday_advance: item[:bookday_advance],
      user_id: User.find_by(email: item[:user_email]).id
    )

    if item[:image].present?
      restaurant.image = File.open(Rails.root.join(item[:image]))
    end

    if item[:menus].present?
      restaurant.menus = item[:menus].map { |menu| File.open(Rails.root.join(menu)) }
    end

    if restaurant.save
      puts "成功建立餐廳：#{restaurant.name}"
    else
      puts "錯誤原因："
      restaurant.errors.full_messages.each do |message|
        puts "- #{message}"
      end
    end

    if item[:holidays].present?
      item[:holidays].each do |holiday|
        Holiday.create(dayoff: holiday, restaurant_id: restaurant.id)
      end
    end

    if item[:open_times].present?
      item[:open_times].each do |open_time|
        OpenTime.create(start_time: open_time[:start_time], end_time: open_time[:end_time], restaurant_id: restaurant.id)
      end
    end
  end
end

puts "餐廳資料建立完成"
