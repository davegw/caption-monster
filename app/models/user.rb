class User < ActiveRecord::Base
  has_many :entries
  has_many :labels
  has_many :votes

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validate :registered_user_has_valid_password
  validates_presence_of :email
  validates_presence_of :name
  validates_uniqueness_of :email
  validates_uniqueness_of :name


  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def eligible?(label)
    !Vote.has_voted?(self.id, label)
  end

  def registered?
    status_id == UserStatus::REGISTERED
  end

  def self.create_unregistered
    unregistered_name = User.generate_name
    User.create(:name => unregistered_name,
                :email =>  unregistered_name.gsub(/AnonyMonster /, '').downcase + '@captionmonster.com',
                :status_id => UserStatus::UNREGISTERED)

  end

  def transfer_unregistered!(unregistered_user)
    unregistered_user.entries.each do |e|
      e.user_id = id
      e.save
    end
    unregistered_user.labels.each do |l|
      l.user_id = id
      l.save
    end
    unregistered_user.votes.each do |v|
      v.user_id = id
      v.save
    end
    
  end

  def self.generate_name
    consonants = ['b','c','d','f','g','h','j','k','l','m','n','p','q','r','s','t','v','w','x','y','z']
    vowels = ['a','e','i','o','u']
    anonymous_name = "AnonyMonster"

    random_name = ''
    4.times do
      random_name << consonants.sample.upcase
      random_name << vowels.sample
    end
    name = anonymous_name + ' ' + random_name
    name
  end

  def anon_name
    raise 'Not an unregistered user' if registered?
    name.gsub(/AnonyMonster /, '')
  end

  private 
    def registered_user_has_valid_password
      return if status_id == UserStatus::UNREGISTERED
      errors.add(:password, 'must be at least 4 characters') if
        registered? && password && password.length < 4
    end

end
