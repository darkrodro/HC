class DatoMedico < ActiveRecord::Base
  acts_as_list :scope=>'state = \'#{state}\''
  
  state_machine :state, :initial => :active do
    event :delete do
      transition all => :deleted
    end
    event :destroy do
      transition all => :deleted
    end
    event :restore do
      transition all => :active
    end
  end
  
  validates :nombre,  :presence => true 
  validates_uniqueness_of :nombre, :case_sensitive => false
  
end
