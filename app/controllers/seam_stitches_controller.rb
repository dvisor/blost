class SeamStitchesController < ApplicationController
  before_action :set_seam_stitch, only: [:show, :edit, :update, :destroy]

  # GET /seam_stitches
  # GET /seam_stitches.json
  def index
    @seam_stitches = SeamStitch.all
  end

  # GET /seam_stitches/1
  # GET /seam_stitches/1.json
  def show
    @seam_stitch = SeamStitch.find_by_id(params[:id])

    retrieved = @seam_stitch.retrieve({next: params[:next]})
    data = retrieved.map do |seam_stitch|
      {
        id: seam_stitch.id,
        passage: seam_stitch.stitch.passage,
        branches: seam_stitch.branches.map do |branch|
          {
            id: branch.id,
            passage: branch.stitch.passage
          }
        end
      }
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: data }
    end
  end

  # GET /seam_stitches/new
  def new
    @seam_stitch = SeamStitch.new
  end

  # GET /seam_stitches/1/edit
  def edit
  end

  # POST /seam_stitches
  # POST /seam_stitches.json
  def create
    @seam_stitch = SeamStitch.new(seam_stitch_params)

    respond_to do |format|
      if @seam_stitch.save
        format.html { redirect_to @seam_stitch, notice: 'Seam stitch was successfully created.' }
        format.json { render action: 'show', status: :created, location: @seam_stitch }
      else
        format.html { render action: 'new' }
        format.json { render json: @seam_stitch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seam_stitches/1
  # PATCH/PUT /seam_stitches/1.json
  def update
    respond_to do |format|
      if @seam_stitch.update(seam_stitch_params)
        format.html { redirect_to @seam_stitch, notice: 'Seam stitch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @seam_stitch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seam_stitches/1
  # DELETE /seam_stitches/1.json
  def destroy
    @seam_stitch.destroy
    respond_to do |format|
      format.html { redirect_to seam_stitches_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seam_stitch
      @seam_stitch = SeamStitch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seam_stitch_params
      params.require(:seam_stitch).permit(:seam_id, :stitch_id, :prev_seam_stitch_id, :next_seam_stitch_id)
    end
end