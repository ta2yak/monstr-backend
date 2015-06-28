FactoryGirl.define do
  factory :user do
    provider "monstr"      # required not omniauth
    uid SecureRandom.uuid  # required not omniauth
    name "Test User"
    email "test@example.com"
    password "please123"
  end
end
