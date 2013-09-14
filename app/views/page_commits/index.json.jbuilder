json.array!(@stitch_commits) do |stitch_commit|
  json.extract! stitch_commit, :stitch_id, :git_object_id
  json.url stitch_commit_url(stitch_commit, format: :json)
end
