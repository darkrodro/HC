# Load the rails application
require File.expand_path('../application', __FILE__)

ActiveSupport::Inflector.inflections do |inflect|
    inflect.plural "analisis", "analisis"
    inflect.singular "analisis", "analisis"
    
    inflect.plural "dato_medico", "datos_medicos"
    inflect.singular "datos_medicos", "dato_medico"
    
    inflect.plural "evaluacion", "evaluaciones"
    inflect.singular "evaluaciones", "evaluacion"
end 

# Initialize the rails application
HC::Application.initialize!

Date::DATE_FORMATS[:default] = "%d/%m/%Y"









