class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(:title => params[:entry][:title])
    @entry.save
    redirect_to entry_url
  end

end
