class User < ActiveRecord::Base
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader
  has_many :songs, dependent: :delete_all
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  VALID_EMAIL_REGEX =/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A[A-Za-z][A-Za-z0-9._-]{2,19}\z/
  validates :name, presence: true,
                            length: { maximum: 50 },
                            format: { with: VALID_NAME_REGEX },
                            uniqueness: { case_sensitive: false }
  validates :email, presence: true,
                            format: { with: VALID_EMAIL_REGEX },
                            uniqueness: { case_sensitive: true }
  validates :password, presence: true,
                                  confirmation: true,
                                  length: { in: 6..16 },
                                  on: :create
  validates :bio, length: { maximum: 140 }

  #Find user by name
  def to_param
    name
  end
end
