class Stitch < ActiveRecord::Base

  attr_reader :char_limit


  belongs_to :stitch_commit
  has_many :stitch_commits

  belongs_to :source_stitch_commit, class_name: :StitchCommit

  has_many :seam_stitches
  has_many :seams, through: :seam_stitches

  after_initialize :set_defaults

  validate :verify_passage

  before_save :pre_save
  after_save :post_save

  def set_defaults
    @char_limit = 2048
  end


  def normalize_passage(passage)
    passage.strip.gsub(/\s+/, " ") rescue ""
  end


  def passage
    @passage || stitch_commit.passage rescue nil
    # if stitch_commit
    #   @passage = stitch_commit.passage
    # end
    # @passage
  end

  def passage=(passage)
    puts passage
    @passage = normalize_passage(passage)
    puts @passage
    # @passage =

    # if new_record?
    #   @passage = passage

      
    # normalize_passage
    # stitch_commit.passage = passage
  end

  def verify_passage
    puts "#{self.class.name}.#{__method__}"
    puts @passage

    if @passage.blank?
      errors.add(:stitch, "Passage cannot be blank.")
    else
      if @passage.length > char_limit 
        errors.add(:stitch, "Passage character limit #{@char_limit} exceeded.")
      end
    end

  end

  private

  def pre_save
    puts __method__

    if stitch_commit && stitch_commit.contains?(@passage)
    else
      puts "Creating StitchCommit"
      self.stitch_commit_id = StitchCommit.create(passage: @passage).id
      puts self
    end
  end

  def post_save
    puts __method__

    puts "Attaching StitchCommit"
    stitch_commit.update_attribute(:stitch_id, self.id)
    puts self

  end



end
