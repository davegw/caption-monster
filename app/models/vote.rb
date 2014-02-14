class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :label

  def self.log_vote(vote, label, user)
    Vote.create(:label_id => label, :user_id => user, :result => vote)
  end

  def self.has_voted?(user, label)
    return true if Vote.where(:user_id => user, :label_id => label).any?
    return false
  end
end
