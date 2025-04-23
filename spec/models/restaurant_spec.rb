# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe '驗證' do
    it '具有有效的factory' do
      expect(build(:restaurant)).to be_valid
    end

    context '必填欄位驗證' do
      it '沒有名稱時無效' do
        restaurant = build(:restaurant, name: nil)
        expect(restaurant).not_to be_valid
        expect(restaurant.errors[:name]).to include("不能為空白")
      end

      it '沒有URL時無效' do
        restaurant = build(:restaurant, url: nil)
        expect(restaurant).not_to be_valid
        expect(restaurant.errors[:url]).to include("不能為空白")
      end

      it '沒有電話時無效' do
        restaurant = build(:restaurant, tel: nil)
        expect(restaurant).not_to be_valid
        expect(restaurant.errors[:tel]).to include("不能為空白")
      end

      it '沒有地址時無效' do
        restaurant = build(:restaurant, address: nil)
        expect(restaurant).not_to be_valid
        expect(restaurant.errors[:address]).to include("不能為空白")
      end
    end

    context 'URL唯一性驗證' do
      it '相同URL時無效' do
        create(:restaurant, url: 'test-restaurant')
        restaurant = build(:restaurant, url: 'test-restaurant')
        expect(restaurant).not_to be_valid
        expect(restaurant.errors[:url]).to include("已經被使用")
      end
    end
  end

  describe '關聯關係' do
    it { should belong_to(:user) }
    it { should have_many(:reservations).dependent(:destroy) }
    it { should have_many(:open_times).dependent(:destroy) }
    it { should have_many(:tables).dependent(:destroy) }
    it { should have_many(:holidays).dependent(:destroy) }
  end

  describe '預設值' do
    let(:restaurant) { create(:restaurant) }

    it '預設reserve_interval為15' do
      expect(restaurant.reserve_interval).to eq(15)
    end

    it '預設mealtime為60' do
      expect(restaurant.mealtime).to eq(60)
    end

    it '預設bookday_advance為14' do
      expect(restaurant.bookday_advance).to eq(14)
    end
  end

  describe '#should_generate_new_friendly_id?' do
    let(:restaurant) { create(:restaurant) }

    it 'URL改變時返回true' do
      restaurant.url = 'new-url'
      expect(restaurant.should_generate_new_friendly_id?).to be true
    end

    it 'URL沒有改變時返回false' do
      expect(restaurant.should_generate_new_friendly_id?).to be false
    end
  end

  describe '軟刪除' do
    it '支持軟刪除' do
      restaurant = create(:restaurant)
      expect { restaurant.destroy }.not_to change { Restaurant.unscoped.count }
      expect(restaurant.deleted_at).not_to be_nil
    end
  end

  describe '圖片上傳' do
    it '可以上傳圖片' do
      restaurant = create(:restaurant)
      expect(restaurant.respond_to?(:image)).to be true
      expect(restaurant.respond_to?(:image=)).to be true
    end

    it '可以上傳菜單' do
      restaurant = create(:restaurant)
      expect(restaurant.respond_to?(:menus)).to be true
      expect(restaurant.respond_to?(:menus=)).to be true
    end
  end
end
