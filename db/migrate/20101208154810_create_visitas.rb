class CreateVisitas < ActiveRecord::Migration
  def self.up
    create_table :visitas do |t|
      t.date :fecha
      t.string :ecg
      t.string :estado_actual
      t.string :rx_del_torax
      t.string :presion_arterial
      t.string :analisis
      t.string :pulso
      t.string :auscultacion
      t.string :otros_estudios
      t.string :aparato_respiratorio
      t.string :tratamiento
      t.string :otros_aparatos
      t.string :observaciones
      
      t.integer :paciente_id

      t.timestamps
    end
  end

  def self.down
    drop_table :visitas
  end
end
