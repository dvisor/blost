class PageCommit < ActiveRecord::Base

  validates_presence_of :git_object_id

  belongs_to :git_object
  belongs_to :page

  before_validation :set_git_object

  def author
    self.page.author rescue nil
  end

  def passage
    @passage || git_object.content rescue nil
  end

  def passage=(passage)
    @passage = passage
  end

  def set_git_object
    puts __method__
    self.git_object_id = GitObject.retrieve(@passage).id
  end

  def contains?(passage)
    if @passage.nil?
      return git_object.contains?(passage) rescue false
    else
      return @passage == passage
    end
  end

  # def self.commit(stitch_id, passage)

  #   if git_object.contains?(passage)

  #   last_stitch_commit = StitchCommit.find_by_id(Stitch.find_by_id(stitch_id) || nil) || StitchCommit.new()


  #   if StitchCommit.different?(passage)

  #     StitchCommit.create(stitch_id: stitch, passage: passage)
  #     self.number = number.gsub(/[^0-9]/, "") if attribute_present?("number")
  #   end



  # end

end
