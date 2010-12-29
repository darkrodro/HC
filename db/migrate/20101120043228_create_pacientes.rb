class CreatePacientes < ActiveRecord::Migration
  def self.up
    create_table :pacientes do |t|
      t.string :nombre, :null=>false
      t.string :apellido, :null=>false
      t.integer :documento, :null=>false
      t.string :sexo
      t.date :fecha_nacimiento
      t.string :telefono
      t.string :domicilio
      t.string :profesion
      t.string :obra_social, :null=>false
      t.string :obra_social_numero
      
      t.timestamps
    end
  end

  def self.down
    drop_table :pacientes
  end
end
