json.set! :status, :success

json.post do
  json.merge! @post.attributes
  json.user @post.user, :name, :nickname, :image
  #json.revisions @post.revisions, :headline, :diff_text, :created_at

  json.revisions do
    json.array! @post.revisions do |revision|
      json.merge! revision.attributes
      json.user revision.user, :name, :nickname, :image
    end
  end

end
