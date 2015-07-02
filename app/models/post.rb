class Post < ActiveRecord::Base
  belongs_to :user
  has_one :index, dependent: :destroy
  has_many :revisions, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  before_save do |post|

    # Reset this post's index
    post.index.destroy if post.index.present?

    # Remove first char If First char is /
    post.title.sub!(%r[^/], "")

    # Generate Index and connect post and set last index to title
    indexes_values = post.title.split("/")

    index = Index.find_or_create_by_path(indexes_values)
    index.post = post
  end

  after_save do |post|

    # check update column
    # Create Revision on update (only title, body, is_wip)
    if post.title_changed? || post.body_changed? || post.is_wip_changed?

      new_text = build_revision_message(post.title, post.body, post.is_wip)
      prev_text = build_revision_message(post.title_was, post.body_was, post.is_wip_was)

      headline = Diffy::Diff.new(prev_text, new_text, :context => 0).first.chomp
      diff_text = Diffy::Diff.new(prev_text, new_text, :context => 5).to_s(:text)

      Revision.create({headline:headline, full_text:new_text, diff_text:diff_text, user:post.user, post:post})

    end

  end

  def as_json(options = {})
    	super(:include => {:revisions => {}})
  end

private

  def build_revision_message(title, body, is_wip)
    message_array = []
    message_array << title if title.present?
    message_array << body if body.present?
    message_array << (is_wip ? "Save as WIP": "Ship it!") if is_wip.present?
    message_array << "" # fix \ No newline at end of file
    message_array.join("\n")
  end

end
