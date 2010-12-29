class CreateEvaluaciones < ActiveRecord::Migration
  def self.up
    create_table :evaluaciones do |t|
      t.integer :paciente_id
      t.integer :dato_medico_id
      t.string :valor
      
      t.timestamps
    end
    
    add_index :evaluaciones, [:paciente_id, :dato_medico_id], :unique => true
  end

  def self.down
    drop_table :evaluaciones
  end
end
