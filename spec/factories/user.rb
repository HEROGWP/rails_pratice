FactoryGirl.define do
  factory :user, class: User do
    email "test@gmail.com" 
    password "12345678"
    password_confirmation "12345678"
    role "admin"
  end
end