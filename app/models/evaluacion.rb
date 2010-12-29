class Evaluacion < ActiveRecord::Base
  belongs_to :paciente
  belongs_to :dato_medico
  
  validates :valor,  :presence => true 

end
