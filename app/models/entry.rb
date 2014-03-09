class Entry < ActiveRecord::Base
  belongs_to :user
  has_many :labels, :dependent => :destroy
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>", :original => "1100x1100>" }, 
                    :convert_options => { :all => '-auto-orient' },
                    :default_url => "/system/entries/photos/no_image.jpg"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_presence_of :photo
  validates_presence_of :title

  def self.find_by_user_id(id)
    Entry.where(:user => 
                User.find(id))
  end
end
