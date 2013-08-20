class OfferedPagesController < ApplicationController
  before_action :set_offered_page, only: [:show, :edit, :update, :destroy]

  # GET /offered_pages
  # GET /offered_pages.json
  def index
    @offered_pages = OfferedPage.all
  end

  # GET /offered_pages/1
  # GET /offered_pages/1.json
  def show
  end

  # GET /offered_pages/new
  def new
    @offered_page = OfferedPage.new
  end

  # GET /offered_pages/1/edit
  def edit
  end

  # POST /offered_pages
  # POST /offered_pages.json
  def create
    @offered_page = OfferedPage.new(offered_page_params)

    respond_to do |format|
      if @offered_page.save
        format.html { redirect_to @offered_page, notice: 'Offered page was successfully created.' }
        format.json { render action: 'show', status: :created, location: @offered_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @offered_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offered_pages/1
  # PATCH/PUT /offered_pages/1.json
  def update
    respond_to do |format|
      if @offered_page.update(offered_page_params)
        format.html { redirect_to @offered_page, notice: 'Offered page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @offered_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offered_pages/1
  # DELETE /offered_pages/1.json
  def destroy
    @offered_page.destroy
    respond_to do |format|
      format.html { redirect_to offered_pages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offered_page
      @offered_page = OfferedPage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offered_page_params
      params.require(:offered_page).permit(:page_commit_id, :seam_stitch_id)
    end
end
