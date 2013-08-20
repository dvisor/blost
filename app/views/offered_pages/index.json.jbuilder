json.array!(@offered_pages) do |offered_page|
  json.extract! offered_page, :page_commit_id, :seam_stitch_id
  json.url offered_page_url(offered_page, format: :json)
end
