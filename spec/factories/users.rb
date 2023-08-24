FactoryBot.define do
  factory :user do
    
    

    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)}
    password_confirmation {password}

    transient do
      person { Gimei.name }
    end

    last_name             {person.last.kanji }
    first_name            {person.first.kanji }
    last_name_kana        {person.last.katakana }
    first_name_kana       {person.first.katakana}
    birth_date            {Faker::Date.backward}
  end
end