class LabelsController < ApplicationController
  def create
    if current_user
      user = current_user
    else
      user = User.create_unregistered
      session[:user_id] = user.id
    end
    @label = Label.new(:message => params[:label][:message], :entry_id => params[:label][:entry_id], :user_id => user.id)
    @label.save
    redirect_to show_entry_url(@label.entry_id)
  end

  def new
    @entry = Entry.find(params[:id])
    @label = Label.new
  end

  def index
    # @labels = Label.all(:order => "created_at DESC", :limit => 10)
    if params[:query]
      query = "%" + params[:query] + "%"
      @labels = Label.where("message like ?", query)
      redirect_to show_entry_path(@labels.first.entry.id) if @labels.count == 1
    else
      @labels = Label.all(:order => "created_at DESC", :limit => 10)
    end
  end

  def user_captions
    @labels = Label.find_by_user_id(params[:id])
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