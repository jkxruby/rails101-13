class PostsController < ApplicationController

def index
  @group = Group.find(params[:group_id])
  @posts = Post.all
end

def new
  @group = Group.find(params[:group_id])
  @post = Post.new
end

def create
   @group = Group.find(params[:group_id])
   @post = Post.find(params[:id])
   @post.group = @group
   @post.user = current_user
   if @post.save
     redirect_to group_posts_path(@group)
   else
     render :new
   end
 end 



end
