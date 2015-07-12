class Revision < ActiveRecord::Base
  default_scope -> { includes(:user).order('created_at desc')}

  belongs_to :user
  belongs_to :post

end
