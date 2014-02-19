class LabelsController < ApplicationController
  def create
    @entry_id = params[:label][:entry_id]
    user = current_user.id if current_user
    Label.create(:message => params[:label][:message], :entry_id => @entry_id, :user_id => user)
    redirect_to show_entry_url(@entry_id)
  end

  def index
    # @labels = Label.all(:order => "created_at DESC", :limit => 10)
    if params[:query]
      @labels = Label.where("message like '%#{params[:query]}%'")
      redirect_to show_entry_path(@labels.first.entry.id) if @labels.count == 1
    else
      @labels = Label.all(:order => "created_at DESC", :limit => 10)
    end
  end

  def up_vote
    errors = []
    if current_user && Vote.where(:user_id => current_user.id, :label_id => params[:id]).any?
      errors = "Already voted on this caption"
    else
      @label = Label.find(params[:id])
      @label.up_votes = @label.up_votes + 1
      @label.save
      user = current_user.id if current_user
      Vote.log_vote(VoteResult::UP, @label.id, user)
    end
    render :json => { :success => errors.empty?, :errors => errors }
  end

  def down_vote
    errors = []
    if current_user && Vote.where(:user_id => current_user.id, :label_id => params[:id]).any?
      errors = "Already voted on this caption"
    else
      @label = Label.find(params[:id])
      @label.down_votes = @label.down_votes + 1
      @label.save
      user = current_user.id if current_user
      Vote.log_vote(VoteResult::DOWN, @label.id, user)
    end
    render :json => { :success => errors.empty?, :errors => errors }
  end

end