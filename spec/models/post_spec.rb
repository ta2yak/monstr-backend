require 'rails_helper'

RSpec.describe Post, type: :model do

  before(:each) {
    @post = FactoryGirl.create(:post)
    @user = FactoryGirl.create(:user)
    @post.user = @user
  }

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:is_wip) }
  it { should respond_to(:user) }

  it "#title returns a string" do
    expect(@post.title).to match 'HelloWorld'
  end

  it "#body returns a string" do
    expect(@post.body).to match 'Hello World'
  end

  it "#is_wip returns a boolean" do
    expect(@post.is_wip).to match false
  end

  it "#user returns a user" do
    expect(@post.user.id).to match @user.id
  end

end
