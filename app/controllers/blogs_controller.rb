class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :destroy]

  # GET /blogs
  def index
    @blogs = Blog.order("created_at").all
  end

  # GET /blogs/1
  def show
    @blog = Blog.includes(:entries).find(params[:id])
    # ↓セキュリティリスク!
    # @blog = Blog.where("id = #{params[:id]}").first
    #                SELECT  "blogs".* FROM "blogs" WHERE (id =
    # ユーザー入力⇒  null) UNION select id, body , null, null from comments where approved='false' --
    #                )  ORDER BY "blogs"."id" ASC LIMIT 1
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  def create
    @blog = Blog.new(blog_params)

    if @blog.save
      redirect_to @blog, notice: 'Blog was successfully created.'
    else
      render :new
      # ・@blog.errors の内容が、newから呼び出される _form に表示される。
      # ・path は /blogs のままとなる。
    end
  end

  # PATCH/PUT /blogs/1
  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: 'Blog was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /blogs/1
  def destroy
    @blog.destroy
    redirect_to blogs_url, notice: 'Blog was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title)
    end
end
