## usersテーブル

|Column              |Type    |Options      |
|--------------------|--------|-------------|
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last-name          | string | null: false |
| first-name         | string | null: false |
| last-name-kana     | string | null: false |
| first-name-kana    | string | null: false |
| birth-date         | date   | null: false |

### Association
- has_many :items
- has_many :orders


## itemsテーブル

|Column                |Type        |Options      |
|----------------------|------------|-------------|
| item-image           | string     | null: false |
| item-name            | string     | null: false |
| item-info            | text       | null: false |
| category             | string     | null: false |
| item-sales-status    | string     | null: false |
| shipping-fee-status  | string     | null: false |
| item-prefecture      | string     | null: false |
| price                | integer    | null: false |
| user                 | references | null: false, foreign_key: true | 

### Association
- belongs_to :user
- has_one :order


## ordersテーブル

|Column|Type|Options|
|------|----|-------|
| user | references | null: false, foreign_key: true |
| item | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping-address


## shipping-addressesテーブル

|Column            |Type        |Options      |
|------------------|------------|-------------|
| postal-code      | string     | null: false |
| order-prefecture | string     | null: false |
| city             | string     | null: false |
| addresses        | string     | null: false |
| building         | string     | 
| phone-number     | string     | null: false |
| order            | references | null: false, foreign_key: true | 


### Association
- belongs_to :order
