require 'rails_helper'

describe User do

  before(:each) { @user = FactoryGirl.create(:user) }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'test@example.com'
  end

end
