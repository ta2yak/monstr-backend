require 'rails_helper'

describe Post do

  before(:each) { @post = FactoryGirl.create(:post) }

  subject { @post }

  it { should respond_to(:title) }

  it "#title returns a string" do
    expect(@post.title).to match 'Hoge Fuga Title'
  end

end
