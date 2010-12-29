class EncabezadoYPie < ActiveRecord::Base
  set_table_name "encabezado_y_pie"
  
  def self.get_instance
    res = first
    unless res
      res = new
      res.save
    end
    
    res
  end
end
