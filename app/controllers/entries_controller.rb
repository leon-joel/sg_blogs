class EntriesController < ApplicationController
  before_action :set_entry, only: [ :edit, :update, :destroy]

  # GET /blogs/:blog_id/entries/:id
  def show
    @entry = Entry.includes(:comments).find(params[:id])
    # p @entry
    if @entry.blog_id.to_s != params[:blog_id]
      # p params[:blog_id]
      redirect_to (request.referer || blog_path(params[:blog_id])), notice: '不整合'
    end

    @blog = Blog.find(params[:blog_id])
    @comment = Comment.new(params.permit(:id))
  end

  # GET /blogs/:blog_id/entries/new
  def new
    @blog = Blog.find(params[:blog_id])
    @entry = Entry.new(params.permit(:blog_id))
  end

  # GET /blogs/:blog_id/entries/:id/edit
  def edit
    if @entry.blog_id.to_s != params[:blog_id]
      redirect_to (request.referer || blog_path(params[:blog_id])), notice: '不整合'
    end
  end

  # POST /blogs/:blog_id/entries
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      redirect_to blog_path(@entry.blog_id, @entry.id), notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  # PATCH /blogs/:blog_id/entries/:id
  def update
    if @entry.blog_id.to_s != params[:blog_id]
      return redirect_to (request.referer || blog_path(params[:blog_id])), notice: '不整合'
    end

    if @entry.update(entry_params)
      redirect_to blog_entry_path(@entry.blog_id, @entry.id), notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /blogs/:blog_id/entries/:id
  def destroy
    if @entry.blog_id.to_s != params[:blog_id]
      return redirect_to (request.referer || blog_path(params[:blog_id])), notice: "不整合"
    end

    msg = @entry.destroy ? 'Entry was successfully destroyed.' : 'Failed to delete entry.'
    redirect_to blog_path(params[:blog_id]), notice: msg
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
