class Documento < ActiveRecord::Base
  belongs_to :visita
  
  validates_presence_of :contenido
  validates_inclusion_of :tipo, :in => ["receta", "indicaciones", "estudios", "analisis"]
end
