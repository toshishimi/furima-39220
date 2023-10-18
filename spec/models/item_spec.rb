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
          expect(@item.errors.full_messages).to include('Userを入力してください')
        end

      context "どれか一つでも空、もしくは『----』では出品できない" do
        it "商品画像が空では出品できない" do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("画像を入力してください")
        end

        it "商品名が空では出品できない" do
          @item.item_name = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("商品名を入力してください")
        end

        it "商品の説明が空では出品できない" do
          @item.item_info = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("商品の説明を入力してください")
        end

        it "カテゴリーが『----』では出品できない" do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
        end

        it "商品の状態が『----』では出品できない" do
          @item.item_status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("商品の状態を選択してください")
        end

        it "配送料の負担が『----』では出品できない" do
          @item.shipping_status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
        end

        it "発送元の地域が『----』では出品できない" do
          @item.prefecture_id  = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
        end

        it "発送までの日数が『----』では出品できない" do
          @item.scheduled_delivery_id  = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
        end

        it "価格が空では出品できない" do
          @item.price  = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
        end
      end

      context "価格が範囲外だと出品できない" do
        it "価格が299以下だと出品できない" do
          @item.price  = 299
          @item.valid?
          expect(@item.errors.full_messages).to include("販売価格は300以上の値にしてください")
        end

        it "価格が10000000以上だと出品できない" do
          @item.price  = 10000000
          @item.valid?
          expect(@item.errors.full_messages).to include("販売価格は9999999以下の値にしてください")
        end
      end
      it "価格に少数が含まれると出品できない" do
        @item.price = 300.1
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は整数で入力してください")
      end


    end


  end

end
