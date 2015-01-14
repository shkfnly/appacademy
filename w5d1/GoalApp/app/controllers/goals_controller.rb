class GoalsController < ApplicationController
  before_action :redirect_if_not_author, only: [:show, :edit, :update, :destroy]

  def index
    @goals = Goal.where(privacy: false)
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to user_goal_url(id: @goal.id, user_id: current_user.id)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(current_user)
  end

  private

    def goal_params
      params.require(:goal).permit(:title, :body, :user_id, :privacy)
    end

    def redirect_if_not_author
      @goal = Goal.find(params[:id])
      redirect_to user_url(current_user) unless @goal.privacy == false || @goal.user_id == current_user.id
    end
end
