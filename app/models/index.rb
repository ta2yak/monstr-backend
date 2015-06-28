class Index < ActiveRecord::Base
  has_closure_tree

  belongs_to :post

end
