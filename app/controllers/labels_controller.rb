class LabelsController < ApplicationController
  def create
    @entry_id = params[:label][:entry_id]
    Label.create(:message => params[:label][:message], :entry_id => @entry_id)
    redirect_to show_entry_url(@entry_id)
  end

  def index
    @labels = Label.last(10)
  end

  def up_vote
    @label = Label.find(params[:id])
    @label.up_votes = @label.up_votes + 1
    @label.save
    render :json => { :success => true }
  end

  def down_vote
    @label = Label.find(params[:id])
    @label.down_votes = @label.down_votes + 1
    @label.save
    render :json => { :success => true }
  end

end