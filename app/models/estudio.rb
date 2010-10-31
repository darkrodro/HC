class Estudio < ActiveRecord::Base
  validates :nombre,  :presence => true 
end
