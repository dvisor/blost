class PageCommitsController < ApplicationController
  before_action :set_page_commit, only: [:show, :edit, :update, :destroy]

  # GET /page_commits
  # GET /page_commits.json
  def index
    @page_commits = PageCommit.all
  end

  # GET /page_commits/1
  # GET /page_commits/1.json
  def show
  end

  # GET /page_commits/new
  def new
    @page_commit = PageCommit.new
  end

  # GET /page_commits/1/edit
  def edit
  end

  # POST /page_commits
  # POST /page_commits.json
  def create
    @page_commit = PageCommit.new(page_commit_params)

    respond_to do |format|
      if @page_commit.save
        format.html { redirect_to @page_commit, notice: 'Page commit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @page_commit }
      else
        format.html { render action: 'new' }
        format.json { render json: @page_commit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /page_commits/1
  # PATCH/PUT /page_commits/1.json
  def update
    respond_to do |format|
      if @page_commit.update(page_commit_params)
        format.html { redirect_to @page_commit, notice: 'Page commit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page_commit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_commits/1
  # DELETE /page_commits/1.json
  def destroy
    @page_commit.destroy
    respond_to do |format|
      format.html { redirect_to page_commits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_commit
      @page_commit = PageCommit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_commit_params
      params.require(:page_commit).permit(:page_id, :git_object_id)
    end
end
