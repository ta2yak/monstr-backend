class Index < ActiveRecord::Base
  has_closure_tree

  belongs_to :post

  after_destroy do |index|

    index.parent.cleanup if index.parent.present?

  end

  def cleanup
    self.reload # require
    if self.deletable?
      self.destroy
    end
  end

  def deletable?
    self.leaf?
  end

end
