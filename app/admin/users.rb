ActiveAdmin.register User do
  
  config.batch_actions = true
  
  #filter :company ,:as => :select, :collection => proc {Company.all.map{|x| x.name}}
  #filter :details, :polymorphic => true ,:as => :select, :collection => proc {Company.all.map{|x| x.name}}
  
  filter :id
  filter :email
  filter :approved
  filter :topics
  filter :bio
  filter :token
  filter :hourlyrate
  filter :street
  filter :city
  filter :state
  filter :country
  filter :phonenumber
  filter :zipcode
  filter :displayInfo
  filter :firstname
  filter :lastname
  filter :priority
  filter :created_at
  filter :updated_at

  index :download_links => false do
    column("id", :sortable => :id)
    column("Email") {|user| (user.email) }
    column("Topics") {|user| (user.topics) }
    column("bio") {|user| (user.bio) }
    column("Company Name") {|user| (user.details.name if user.details and user.details_type == "Company") }
    column("token") {|user| (user.token) }
    column("hourlyrate") {|user| (user.hourlyrate) }
    column("street") {|user| (user.street) }
    column("city") {|user| (user.city) }
    column("state") {|user| (user.state) }
    column("country") {|user| (user.country) }
    column("phonenumber") {|user| (user.phonenumber) }
    column("avatar_file_name") {|user| (user.avatar_file_name) }
    column("created_at") {|user| (user.created_at) }
    column("updated_at") {|user| (user.updated_at) }
    column("zipcode") {|user| (user.zipcode) }
    column("displayInfo") {|user| (user.displayInfo) }
    column("FirstName") {|user| (user.firstname) }
    column("LastName") {|user| (user.lastname) }
    column("Priority") {|user| (user.priority) }
    column("approved") {|user| status_tag(user.approved ? 'Yes' : 'No' , user.approved ? 'ok'  : 'error') }
    default_actions
    
  end
  
  
  show :download_links => false do
    panel "User Updated Information" do
      attributes_table_for resource do
        #row :name
        row :email
        row :topics
        row :bio
        row :token
        row :hourlyrate
        row :street
        row :city
        row :state
        row :country
        row :phonenumber
        row :avatar_file_name
        row :created_at
        row :updated_at
        row :zipcode
        row :displayInfo
        row :approved
        row :firstname
        row :lastname
        row :priority 
      end
    end
  end
  
    
  form do |f|                         
    f.inputs "Edit User" do
      #f.input :details, :polymorphic => true , :collection => Company.all.map {|u| [u.name, u.id]}
      f.input :topics
      f.input :bio
      f.input :token
      f.input :hourlyrate
      f.input :street
      f.input :city
      f.input :state
      f.input :phonenumber
      f.input :favoritecolor
      f.input :avatar_file_name
      f.input :created_at
      f.input :updated_at
      f.input :zipcode
      f.input :display_address
      f.input :display_phone
      f.input :approved
      f.input :firstname
      f.input :lastname
      f.input :priority
    end                               
    f.actions                        
  end
  
end
