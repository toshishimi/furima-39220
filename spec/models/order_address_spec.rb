require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id) 
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @order_address.user_id = 1
        expect(@order_address).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @order_address.item_id = 1
        expect(@order_address).to be_valid
      end
      it '都道府県が「---」でなければ保存できる' do
        @order_address.prefecture_id = 2
        expect(@order_address).to be_valid
      end
      it '建物名が空でも保存できる' do
        @order_address.building = nil
        expect(@order_address).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できる' do
        @order_address.phone_number = 12_345_678_910
        expect(@order_address).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @order_address.postcode = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode can't be blank", 'Postcode is invalid. Include hyphen(-)')
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @order_address.postcode = 1_234_567
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」だと保存できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @order_address.address = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @order_address.phone_number = '123 - 1234 - 1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上だと保存できないこと' do
        @order_address.phone_number = 12_345_678_910_123_111
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が9桁以下だと保存できないこと' do
        @order_address.phone_number = 12_345_678_9
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'トークンが空だと保存できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
