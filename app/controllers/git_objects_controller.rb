class GitObjectsController < ApplicationController
  before_action :set_git_object, only: [:show, :edit, :update, :destroy]

  # GET /git_objects
  # GET /git_objects.json
  def index
    @git_objects = GitObject.all
  end

  # GET /git_objects/1
  # GET /git_objects/1.json
  def show
  end

  # GET /git_objects/new
  def new
    @git_object = GitObject.new
  end

  # GET /git_objects/1/edit
  def edit
  end

  # POST /git_objects
  # POST /git_objects.json
  def create
    @git_object = GitObject.new(git_object_params)

    respond_to do |format|
      if @git_object.save
        format.html { redirect_to @git_object, notice: 'Git object was successfully created.' }
        format.json { render action: 'show', status: :created, location: @git_object }
      else
        format.html { render action: 'new' }
        format.json { render json: @git_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /git_objects/1
  # PATCH/PUT /git_objects/1.json
  def update
    respond_to do |format|
      if @git_object.update(git_object_params)
        format.html { redirect_to @git_object, notice: 'Git object was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @git_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /git_objects/1
  # DELETE /git_objects/1.json
  def destroy
    @git_object.destroy
    respond_to do |format|
      format.html { redirect_to git_objects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_git_object
      @git_object = GitObject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def git_object_params
      params.require(:git_object).permit(:sha1, :content)
    end
end
