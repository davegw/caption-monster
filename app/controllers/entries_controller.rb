class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(:title => params[:entry][:title], :photo => params[:entry][:photo])
    @entry.save
    redirect_to show_entry_path(@entry.id)
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to entries_index_path
  end

  def index
    @entries = Entry.all(:order => "created_at DESC", :limit => 10)
  end

  def show
    @entry = Entry.find(params[:id])
    @label = Label.new
  end

  def sort
    @type = params[:type]
    @entry = Entry.find(params[:entry_id])
    if @type == 'best_score'
      @captions = Label.where(:entry_id => @entry.id).select("*,up_votes - down_votes AS score").order("score DESC")
    else
      @captions = Label.where(:entry_id => @entry.id).order("#{@type}  DESC")
    end
    render :partial => "sort"
  end

end
