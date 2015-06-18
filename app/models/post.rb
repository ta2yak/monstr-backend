class Post < ActiveRecord::Base
  belongs_to :user
  has_one :index, dependent: :destroy

  before_save do |post|
    # Generate Index and connect post and set last index to title
    indexes_values = post.title.split("/")

    post.title = indexes_values.last
    index = Index.find_or_create_by_path(indexes_values)
    index.post = post
  end

end
