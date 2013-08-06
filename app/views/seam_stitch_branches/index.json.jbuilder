json.array!(@seam_stitch_branches) do |seam_stitch_branch|
  json.extract! seam_stitch_branch, :branch_seam_stitch_id, :seam_stitch_id
  json.url seam_stitch_branch_url(seam_stitch_branch, format: :json)
end
