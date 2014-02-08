class LabelsController < ApplicationController
  def create
    @entry_id = params[:label][:entry_id]
    Label.create(:message => params[:label][:message], :entry_id => @entry_id)
    redirect_to show_entry_url(@entry_id)
  end

end