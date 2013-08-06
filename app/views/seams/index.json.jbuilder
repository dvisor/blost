json.array!(@seams) do |seam|
  json.extract! seam, :title, :start_seam_stitch_id, :end_seam_stitch_id, :author_id
  json.url seam_url(seam, format: :json)
end
