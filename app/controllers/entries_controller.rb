class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    user = current_user.id if current_user
    @entry = Entry.new(:title => params[:entry][:title], :photo => params[:entry][:photo], :user_id => user)
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

  def user_entries
    @entries = Entry.find_by_user_id(params[:id])
  end

  def random
    @entry = Entry.offset(rand(Entry.count)).first
    redirect_to show_entry_path(@entry.id)
  end

  def popular
    popular = Label.select("entry_id, COUNT(entry_id)").group("entry_id").order("COUNT(entry_id) DESC")
    @entries = Entry.find(popular.map{|e|e.entry_id})
  end
end
