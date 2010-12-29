class Paciente < ActiveRecord::Base
  validates :nombre,  :presence => true 
  validates :apellido,  :presence => true
  validates :documento,  :presence => true
  validates_uniqueness_of :documento
  validates_numericality_of :documento, :only_integer => true
  validates_inclusion_of :sexo, :in => ["Masculino", "Femenino", nil]
  validates :obra_social,  :presence => true
  
  has_many :evaluacion
  has_many :dato_medico, :through=>:evaluacion

  has_many :visitas
  
  default_scope :order=>"apellido ASC, nombre ASC"
end
