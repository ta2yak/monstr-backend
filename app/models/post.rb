class Post < ActiveRecord::Base
  belongs_to :user
  has_one :index, dependent: :destroy
  has_many :revisions, dependent: :destroy

  before_save do |post|
    # Generate Index and connect post and set last index to title
    indexes_values = post.title.split("/")

    post.title = indexes_values.last
    index = Index.find_or_create_by_path(indexes_values)
    index.post = post
  end

  after_save do |post|

    # check update column
    # Create Revision on update (only title, body, is_wip)
    return if !post.title_changed? && !post.body_changed? && !post.is_wip_changed?

    new_text = build_revision_message(post.title, post.body, post.is_wip)
    prev_text = build_revision_message(post.title_was, post.body_was, post.is_wip_was)

    headline = Diffy::Diff.new(prev_text, new_text).first.chomp
    diff_text = Diffy::Diff.new(prev_text, new_text, :context => 5).to_s(:text)

    Revision.create({headline:headline, full_text:new_text, diff_text:diff_text, user:post.user, post:post})

  end

private

  def build_revision_message(title, body, is_wip)
    message = <<-"EOS"
    #{title}
    #{body}
    #{is_wip ? "Save as WIP": "Ship it!"}
    EOS

    message
  end

end
