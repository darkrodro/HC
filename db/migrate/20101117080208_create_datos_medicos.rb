class CreateDatosMedicos < ActiveRecord::Migration
  def self.up
    create_table :datos_medicos do |t|
      t.string :nombre, :null=>false
      t.string :state
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :datos_medicos
  end
end
