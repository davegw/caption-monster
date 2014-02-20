class Label < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry
  has_many :votes, :dependent => :destroy

  def self.find_by_user_id(id)
    Label.where(:user => 
                User.find(id))
  end
end
