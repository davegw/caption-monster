class ChangeDefaultToVotesForLabels < ActiveRecord::Migration
  def change
    change_column :labels, :up_votes, :integer, :default => 0
    change_column :labels, :down_votes, :integer, :default => 0
  end
end
