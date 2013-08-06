json.array!(@git_objects) do |git_object|
  json.extract! git_object, :sha1, :content
  json.url git_object_url(git_object, format: :json)
end
