class SeamStitchBranchesController < ApplicationController
  before_action :set_seam_stitch_branch, only: [:show, :edit, :update, :destroy]

  # GET /seam_stitch_branches
  # GET /seam_stitch_branches.json
  def index
    @seam_stitch_branches = SeamStitchBranch.all
  end

  # GET /seam_stitch_branches/1
  # GET /seam_stitch_branches/1.json
  def show
  end

  # GET /seam_stitch_branches/new
  def new
    @seam_stitch_branch = SeamStitchBranch.new
  end

  # GET /seam_stitch_branches/1/edit
  def edit
  end

  # POST /seam_stitch_branches
  # POST /seam_stitch_branches.json
  def create
    @seam_stitch_branch = SeamStitchBranch.new(seam_stitch_branch_params)

    respond_to do |format|
      if @seam_stitch_branch.save
        format.html { redirect_to @seam_stitch_branch, notice: 'Seam stitch branch was successfully created.' }
        format.json { render action: 'show', status: :created, location: @seam_stitch_branch }
      else
        format.html { render action: 'new' }
        format.json { render json: @seam_stitch_branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seam_stitch_branches/1
  # PATCH/PUT /seam_stitch_branches/1.json
  def update
    respond_to do |format|
      if @seam_stitch_branch.update(seam_stitch_branch_params)
        format.html { redirect_to @seam_stitch_branch, notice: 'Seam stitch branch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @seam_stitch_branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seam_stitch_branches/1
  # DELETE /seam_stitch_branches/1.json
  def destroy
    @seam_stitch_branch.destroy
    respond_to do |format|
      format.html { redirect_to seam_stitch_branches_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seam_stitch_branch
      @seam_stitch_branch = SeamStitchBranch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seam_stitch_branch_params
      params.require(:seam_stitch_branch).permit(:branch_seam_stitch_id, :seam_stitch_id)
    end
end
