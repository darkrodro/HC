class Estudio < ActiveRecord::Base
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
  
  default_scope without_state(:deleted)
  
  validates :nombre,  :presence => true 
  validates_uniqueness_of :nombre, :case_sensitive => false
  
  default_scope :order=>:nombre
  
end
