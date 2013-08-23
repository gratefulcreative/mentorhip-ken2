ActiveAdmin.register Course do
  
  index :download_links => false do |course|
    column(:id, :sortable => :id) 
    column(:name) 
    column(:category)
    column(:description)
    column(:price)
    column(:ongoing) 
    column(:startdate)
    column(:enddate)
    column(:created_at, :sortable => :created_at)
    
    if false #currently time out issue on index
      column :coursetimes do |course|
        table_for course.coursetimes do
          column "Day" do |coursetime|
            coursetime.dayofweek
          end
          column "Start Time" do |coursetime|
            coursetime.start.strftime("%H:%M")
          end
          column "End Time" do |coursetime|
            coursetime.end.strftime("%H:%M")
          end
        end
      end
    end  
    default_actions
    
  end
  
  show do |course|
    attributes_table do
      rows :id, :name, :category, :description, :price, :ongoing, :startdate, :enddate
    end
    
    panel 'Course Times' do
      table_for course.coursetimes do
        column "Day" do |coursetime|
          coursetime.dayofweek
        end
        column "Start Time" do |coursetime|
          coursetime.start.strftime("%H:%M")
        end
        column "End Time" do |coursetime|
          coursetime.end.strftime("%H:%M")
        end
      end
    end
    
  end
  
  form do |f|                         
    f.inputs "Add/Edit Course" do       
      f.input :name               
      f.input :category
      f.input :description                  
      f.input :price               
      f.input :ongoing
      f.input :startdate                
      f.input :enddate
      f.has_many :coursetimes do |coursetime|
        coursetime.input :dayofweek
        coursetime.input :start, :as => :time_picker
        coursetime.input :end,   :as => :time_picker

      end
    end
    f.actions                         
  end
  
  
end
