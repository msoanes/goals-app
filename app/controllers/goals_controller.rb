class GoalsController < ApplicationController
  before_action :require_login

  def index
    @goals = current_user.viewable_goals.includes(:user)
  end

  def new
    @goal = Goal.new
  end

  def complete
    @goal = Goal.find(params[:id])
    @goal.mark_complete!
    redirect_to @goal
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
    if @goal.viewable_by?(current_user)
      render :show
    else
      flash[:errors] = ["Cannot view private goal"]
      redirect_to :index
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    redirect_to @goal if @goal.user != current_user
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to @goal
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end


  private

  def goal_params
    params.require(:goal).permit(:content, :is_private)
  end
end
