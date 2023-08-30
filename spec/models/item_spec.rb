require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context "出品できる場合" do
      it "すべての項目が存在すれば出品できる" do
        expect(@item).to be_valid
      end
    end

    
    context "出品できない場合" do
      
        it "ユーザー登録していないと出品できない" do
          @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('User must exist')
        end

      context "どれか一つでも空、もしくは『----』では出品できない" do
        it "商品画像が空では出品できない" do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end

        it "商品名が空では出品できない" do
          @item.item_name = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Item name can't be blank")
        end

        it "商品の説明が空では出品できない" do
          @item.item_info = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Item info can't be blank")
        end

        it "カテゴリーが『----』では出品できない" do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Category can't be blank")
        end

        it "商品の状態が『----』では出品できない" do
          @item.item_status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Item status can't be blank")
        end

        it "配送料の負担が『----』では出品できない" do
          @item.shipping_status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping status can't be blank")
        end

        it "発送元の地域が『----』では出品できない" do
          @item.prefecture_id  = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture can't be blank")
        end

        it "発送までの日数が『----』では出品できない" do
          @item.scheduled_delivery_id  = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
        end

        it "価格が空では出品できない" do
          @item.price  = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Price is not a number")
        end
      end

      context "価格が範囲外だと出品できない" do
        it "価格が299以下だと出品できない" do
          @item.price  = 299
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
        end

        it "価格が10000000以上だと出品できない" do
          @item.price  = 10000000
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
        end
      end

    end


  end

end
