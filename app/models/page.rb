class Page < ActiveRecord::Base

  attr_reader :char_limit


  belongs_to :page_commit
  has_many :page_commits

  belongs_to :source_page_commit, class_name: :PageCommit

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
    @passage || page_commit.passage rescue nil
    # if page_commit
    #   @passage = page_commit.passage
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
    # page_commit.passage = passage
  end

  def verify_passage
    puts "#{self.class.name}.#{__method__}"
    puts @passage

    if @passage.blank?
      errors.add(:page, "Passage cannot be blank.")
    else
      if @passage.length > char_limit 
        errors.add(:page, "Passage character limit #{@char_limit} exceeded.")
      end
    end

  end

  private

  def pre_save
    puts __method__

    if page_commit && page_commit.contains?(@passage)
    else
      puts "Creating PageCommit"
      self.page_commit_id = PageCommit.create(passage: @passage).id
      puts self
    end
  end

  def post_save
    puts __method__

    puts "Attaching PageCommit"
    page_commit.update_attribute(:page_id, self.id)
    puts self

  end



end
