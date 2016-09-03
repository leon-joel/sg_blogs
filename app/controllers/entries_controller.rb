class EntriesController < ApplicationController
  before_action :set_entry, only: [ :edit, :update, :destroy]

  # GET /blogs/:blog_id/entries/:id
  def show
    @entry = Entry.includes(:comments).find(params[:id])
    p @entry
    if @entry.blog_id.to_s != params[:blog_id]
      p params[:blog_id]
      redirect_to (request.referer || blog_path(params[:blog_id]))
    end
  end

  # GET /blogs/:blog_id/entries/new
  def new
    @entry = Entry.new(params.permit(:blog_id))
    p @entry
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      redirect_to blog_path(@entry.blog_id), notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:blog_id, :title, :body)
    end
end
