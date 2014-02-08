class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(:title => params[:entry][:title], :photo => params[:entry][:photo])
    @entry.save
    redirect_to show_entry_path(@entry.id)
  end

  def index
    @entries = Entry.last(5)
  end

  def show
    @entry = Entry.find(params[:id])
  end

end
