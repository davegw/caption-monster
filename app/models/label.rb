class Label < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry
  has_many :votes, :dependent => :destroy
end
