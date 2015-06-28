require 'rails_helper'

RSpec.describe Post, type: :model do

  before(:each) {
    @user = FactoryGirl.create(:user)
    @post = FactoryGirl.build(:post)
    @post.user = @user
    @post.save
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

  it "#generate revisions" do
    @post.update(FactoryGirl.attributes_for(:post_rev2))
    @post.update(FactoryGirl.attributes_for(:post_rev3))
    @post.update(FactoryGirl.attributes_for(:post_rev4))
    expect(@post.revisions.tapp.count).to match 4
  end

end
