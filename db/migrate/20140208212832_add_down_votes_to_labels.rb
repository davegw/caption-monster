class AddDownVotesToLabels < ActiveRecord::Migration
  def change
    rename_column :labels, :votes, :up_votes
    add_column :labels, :down_votes, :integer
  end
end
