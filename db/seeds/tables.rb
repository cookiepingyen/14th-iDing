restaurants = [
  {
    restaurant_name: '參食穗餐酒館',
    tables: [
      {
        name: 'A1',
        seat_num: 4,
        site_x: 6,
        site_y: 5
      },
      {
        name: 'A2',
        seat_num: 4,
        site_x: 11,
        site_y: 5
      },
      {
        name: 'A3',
        seat_num: 4,
        site_x: 16,
        site_y: 5
      },
      {
        name: 'A4',
        seat_num: 4,
        site_x: 21,
        site_y: 5
      },
      {
        name: 'A5',
        seat_num: 4,
        site_x: 6,
        site_y: 16
      },
      {
        name: 'A6',
        seat_num: 4,
        site_x: 11,
        site_y: 16
      },
      {
        name: 'A7',
        seat_num: 4,
        site_x: 16,
        site_y: 16
      },
      {
        name: 'A8',
        seat_num: 4,
        site_x: 21,
        site_y: 16
      }
    ],
  },
  {
    restaurant_name: '涮吧-燉雞鍋物',
    tables: [
      {
        name: 'A1',
        seat_num: 4,
        site_x: 1,
        site_y: 18
      },
      {
        name: 'A2',
        seat_num: 4,
        site_x: 1,
        site_y: 14
      },
      {
        name: 'A3',
        seat_num: 4,
        site_x: 1,
        site_y: 10
      },
      {
        name: 'A4',
        seat_num: 4,
        site_x: 1,
        site_y: 6
      },
      {
        name: 'A5',
        seat_num: 4,
        site_x: 1,
        site_y: 2
      },
      {
        name: 'B1',
        seat_num: 4,
        site_x: 12,
        site_y: 16
      },
      {
        name: 'B2',
        seat_num: 4,
        site_x: 12,
        site_y: 11
      },
      {
        name: 'B3',
        seat_num: 4,
        site_x: 12,
        site_y: 6
      },
      {
        name: 'C1',
        seat_num: 4,
        site_x: 19,
        site_y: 1
      }
    ]
  },
  {
    restaurant_name: '一樂漁場',
    tables: [
      {
        name: '1桌',
        seat_num: 4,
        site_x: 9,
        site_y: 1
      },
      {
        name: '2桌',
        seat_num: 4,
        site_x: 9,
        site_y: 5
      },
      {
        name: '3桌',
        seat_num: 4,
        site_x: 9,
        site_y: 9
      },
      {
        name: '4桌',
        seat_num: 4,
        site_x: 14,
        site_y: 9
      },
      {
        name: '5桌',
        seat_num: 4,
        site_x: 19,
        site_y: 9
      },
      {
        name: '6桌',
        seat_num: 4,
        site_x: 24,
        site_y: 9
      },
      {
        name: '7桌',
        seat_num: 4,
        site_x: 29,
        site_y: 9
      }
    ]
  },
  {
    restaurant_name: '牛洞',
    tables: [
      {
        name: '1桌',
        seat_num: 4,
        site_x: 7,
        site_y: 20
      },
      {
        name: '2桌',
        seat_num: 4,
        site_x: 17,
        site_y: 20
      },
      {
        name: '3桌',
        seat_num: 4,
        site_x: 20,
        site_y: 10
      },
      {
        name: '4桌',
        seat_num: 4,
        site_x: 26,
        site_y: 1
      },
      {
        name: '5桌',
        seat_num: 4,
        site_x: 34,
        site_y: 1
      }
    ]
  }
]


restaurants.each do |item|
  restaurant = Restaurant.find_by(name: item[:restaurant_name])
  item[:tables].each do |table|
    Table.create(table.merge(restaurant_id: restaurant.id, category: 0))
  end
end
