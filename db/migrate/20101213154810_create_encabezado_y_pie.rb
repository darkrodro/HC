class CreateEncabezadoYPie < ActiveRecord::Migration
  def self.up
    create_table :encabezado_y_pie do |t|
      t.text :encabezado
      t.text :pie

      t.timestamps
    end
  end

  def self.down
    drop_table :encabezado_y_pie
  end
end
