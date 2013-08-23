class User < ActiveRecord::Base
  ajaxful_rateable :stars => 5, :allow_update => true ,:cache_column => :my_cached_rating
  ajaxful_rater
  #default_scope :order => "priority DESC"
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:registerable,  :recoverable, :rememberable, :trackable,   :omniauthable ,:validatable 
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,  :remember_me, :approved, :token, :favoritecolor, :avatar_file_name, :created_at, :updated_at, :displayInfo, :address
  
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
  # Setup accessible (or protected) attributes for your model...
  
  attr_accessible :topics,:bio,:avatar, :latitude, :longitude, :street, :city, :state, :country, :phonenumber, :slug, :hourlyrate, :zipcode, :latitude, :longtitude, :url, :weburl , :priority 
  attr_accessible :feature , :provider, :uid , :details_type , :firstname , :lastname,:display_address, :display_phone
  
  has_many :courses
  belongs_to :details, :polymorphic => true
  belongs_to :company
  accepts_nested_attributes_for :details

  before_save { |user| user.email = email.downcase }
  
 # validates :name, presence: true, length: { maximum: 50 }
 # validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  #validates_presence_of :password_confirmation, :on => :create
  #validates_inclusion_of:details_type, :in=>["Company","Individual","Purchaser"], :allow_nil=>true
  
  acts_as_gmappable validation: false
  
  def gmaps4rails_address
      self.address
  end
  def gmaps4rails_infowindow
    "<b>#{name}</b><br/>#{address}<br/>#{phonenumber}<br/>"
    #"<a href='#{url_with_protocol(details.weburl)}'>"+"#{details.weburl}</a>"
  end

  #Location: look into geocoder https://github.com/alexreisner/geocoder

  #def to_param
  #  firstname
  #end
  
  #Password Stuffs
  #has_secure_password
  def self.authenticate(token, password)
    find_by_token(token).try(:authenticate, password)
  end
  
  geocoded_by :address
  after_validation :geocode, :if => :city_changed?

  def address
    [street, city, state, country].compact.join(', ')
  end
  
  def get_address
    display_address ?  address : ''
  end
  
  def get_phone
    display_phone ? phonenumber : ''
  end
  
  def line1
    street
  end

  def line2
    [city, state, country].compact.join(', ')
  end
  
  #Token to store in cookie
  before_create { generate_token(:token) }
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  #avatar stuffs
  # s3 Credentials
  options = if Rails.env.production? 
    {:storage => :s3,
      :bucket => 'mentorhip-r',
      :s3_credentials => {
       :access_key_id => 'AKIAIC3NJDNILOITTANA',
       :secret_access_key => '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' }
     }
  else
     {}  
  end
  has_attached_file :avatar, options
  validates_attachment_size :avatar, :less_than => 2.megabytes
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif']
  
  
  def is_provider? 
     details_type == "Company" || details_type == "Individual"
  end
  
  def name 
    if (details_type == "Company" && details.name && details.name.length > 0)
      details.name
    elsif ((details_type=="Individual" || details_type=="Purchaser") && details.firstname && details.firstname.length > 0)
      "#{details.firstname} #{details.lastname}"
    else
      email
    end
  end
  
  def avatar_url
    if avatar?
      avatar.url
    else
      "avatar.png"
    end
  end
  
  def self.featured category = nil
    feature_user =  User.where('feature = ? ',  true).first
    if(category.present?)
      feature_user = User.where("feature = ? and topics in (?)" , true , category).first
    end
    return feature_user
  end
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)    
    user = User.where(:email => auth.info.email).first
    
    if user.nil?
      puts '---------------------------------'
      puts auth.provider
      debugger  
      puts auth.uid
      puts auth.info.email
      puts '---------------------------------'
      user = User.create!(provider:auth.provider,
                          uid:auth.uid,
                          firstname:auth.extra.raw_info.first_name,
                          lastname:auth.extra.raw_info.last_name,
                          email:auth.info.email,
                          password:Devise.friendly_token[0,20],
                          city:auth.info.location,
                          street:auth.extra.raw_info.hometown ,
                          details_type:"Purchaser",
                          state:'' ,
                          country:'')
      user.details = Purchaser.new
      user.details_type="Purchaser"
      user.save
    end
    user
  end
end
