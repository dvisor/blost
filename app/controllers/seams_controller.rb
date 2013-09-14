class SeamsController < ApplicationController
  before_action :set_seam, only: [:show, :edit, :update, :destroy]

  # GET /seams
  # GET /seams.json
  def index
    @seams = Seam.all
  end

  # GET /seams/1
  # GET /seams/1.json
  def show
    @seam_stitch = @seam.seam_stitches.first
  end

  # GET /seams/new
  def new
    @seam = Seam.new
  end

  # GET /seams/1/edit
  def edit
  end

  # POST /seams
  # POST /seams.json
  def create
    @seam = Seam.new(seam_params)

    respond_to do |format|
      if @seam.save
        format.html { redirect_to @seam, notice: 'Seam was successfully created.' }
        format.json { render action: 'show', status: :created, location: @seam }
      else
        format.html { render action: 'new' }
        format.json { render json: @seam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seams/1
  # PATCH/PUT /seams/1.json
  def update
    respond_to do |format|
      if @seam.update(seam_params)
        format.html { redirect_to @seam, notice: 'Seam was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @seam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seams/1
  # DELETE /seams/1.json
  def destroy
    @seam.destroy
    respond_to do |format|
      format.html { redirect_to seams_url }
      format.json { head :no_content }
    end
  end

  def add_stitch

    seam = Seam.find_by_id(params[:seam_id])
    valid_seam = seam ? true : false

    offered_page = OfferedPage.find_by_id(params[:offered_page_id])
    valid_offered_page = offered_page ? true : false

    target_seam_stitch_id = params[:seam_stitch_id]
    target_seam_stitch = SeamStitch.find_by_id(target_seam_stitch_id)
    valid_seam_stitch = target_seam_stitch ? true : false

    position = params[:position]

    
    if valid_offered_page
      page_commit = offered_page.page_commit
    else
      # -- Create new stitch and add to seam
      stitch = Stitch.create(passage: params[:passage])
      page_commit = stitch.errors.present? ? nil : stitch.stitch_commit
    end

    if valid_seam && page_commit
      new_seam_stitch = seam.insert(target_seam_stitch_id, page_commit, {position: position})
      new_seam_stitch_data = new_seam_stitch.jsonize rescue nil
      # seam_stitch = seam.push_stitch(stitch)
      # -- Build response data
      response_data = {
        seam_stitch: {
          data: [new_seam_stitch_data]
        }
      }
    else
      response_data = nil
    end

    respond_to do |format|
      format.html { redirect_to seams_url }
      format.json { render json: response_data }
    end
  end

  def add_branch
    puts "#{self.class.name}.#{__method__}"

    seam_stitch = SeamStitch.find_by_id(params[:seam_stitch_id])
    valid_seam_stitch = seam_stitch ? true : false

    # -- Create new stitch and add to seam
    # stitch = Stitch.create(passage: params['passage'])

    seam_stitch.branch({passage: params[:passage]})
    puts seam_stitch.errors.inspect

    if !seam_stitch.errors.present?

      # -- Build response data
      response_data = {
        seam_stitch: seam_stitch,
        message: seam_stitch.passage
      }
    else
      response_data = nil
    end

    respond_to do |format|
      format.html { redirect_to seams_url }
      format.json { render json: response_data }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seam
      @seam = Seam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seam_params
      params.require(:seam).permit(:title, :start_seam_stitch_id, :end_seam_stitch_id, :author_id)
    end
end
