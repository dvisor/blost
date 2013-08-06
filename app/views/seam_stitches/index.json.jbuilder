json.array!(@seam_stitches) do |seam_stitch|
  json.extract! seam_stitch, :seam_id, :stitch_id, :prev_seam_stitch_id, :next_seam_stitch_id
  json.url seam_stitch_url(seam_stitch, format: :json)
end
