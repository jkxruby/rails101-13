class GroupsController < ApplicationController
before_action :authenticate_user!
def show
  @group = Group.find(params[:id])
  @posts = @group.posts
end

def index
  @groups = Group.all
end

def new
  @group = Group.new
end

def create
  @group = Group.new(group_params)
  @group.user = current_user
  if @group.save

    redirect_to groups_path
  else
    render :new
  end
end

def edit
  @group = Group.find(params[:id])
end

def update
  @group = Group.find(params[:id])
  if @group.update(group_params)
    redirect_to groups_path, notice: "update success"
  else
    render :edit
  end
end

def destroy
  @group = Group.find(params[:id])
  @group.destroy
  redirect_to groups_path, alert: "deleted ,say bye"
end

def join
  @group = Group.find(params[:id])
  if !current_user.is_member_of?(@group)
    current_user.join!(@group)
    flash[:notice] = "join success"
  else
    flash[:alert] = "nonnoooo"
  end
  redirect_to group_path
end

  def quit
    @group = Group.find(params[:id])
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:notice] = "quit success"
    else
      flash[:alert] = "byebye"
    end
    redirect_to group_path
  end


private

def group_params
  params.require(:group).permit(:title, :description)
end

end
