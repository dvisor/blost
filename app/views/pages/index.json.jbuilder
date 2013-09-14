json.array!(@stitches) do |stitch|
  json.extract! stitch, :author_id, :source_stitch_commit_id, :stitch_commit_id
  json.url stitch_url(stitch, format: :json)
end
