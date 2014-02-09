class Entry < ActiveRecord::Base
  belongs_to :user
  has_many :labels
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
                    :default_url => "/system/entries/photos/no_image.jpg",
                    :url => "/assets/:class/:attachment/:id_partition/:style/:filename",
                    :path => ":rails_root/app/assets/images/:class/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
