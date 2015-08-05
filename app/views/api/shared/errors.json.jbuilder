json.set! :status, :error
json.errors do
  json.full_messages @model.errors.full_messages
end
