class StitchCommitsController < ApplicationController
  before_action :set_stitch_commit, only: [:show, :edit, :update, :destroy]

  # GET /stitch_commits
  # GET /stitch_commits.json
  def index
    @stitch_commits = StitchCommit.all
  end

  # GET /stitch_commits/1
  # GET /stitch_commits/1.json
  def show
  end

  # GET /stitch_commits/new
  def new
    @stitch_commit = StitchCommit.new
  end

  # GET /stitch_commits/1/edit
  def edit
  end

  # POST /stitch_commits
  # POST /stitch_commits.json
  def create
    @stitch_commit = StitchCommit.new(stitch_commit_params)

    respond_to do |format|
      if @stitch_commit.save
        format.html { redirect_to @stitch_commit, notice: 'Stitch commit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @stitch_commit }
      else
        format.html { render action: 'new' }
        format.json { render json: @stitch_commit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stitch_commits/1
  # PATCH/PUT /stitch_commits/1.json
  def update
    respond_to do |format|
      if @stitch_commit.update(stitch_commit_params)
        format.html { redirect_to @stitch_commit, notice: 'Stitch commit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @stitch_commit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stitch_commits/1
  # DELETE /stitch_commits/1.json
  def destroy
    @stitch_commit.destroy
    respond_to do |format|
      format.html { redirect_to stitch_commits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stitch_commit
      @stitch_commit = StitchCommit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stitch_commit_params
      params.require(:stitch_commit).permit(:stitch_id, :git_object_id)
    end
end
