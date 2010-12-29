class Visita < ActiveRecord::Base
  belongs_to :paciente
  
  validates :fecha,  :presence => true 
  
  has_many :documentos
  
  default_scope :order=>"fecha DESC"  
end
