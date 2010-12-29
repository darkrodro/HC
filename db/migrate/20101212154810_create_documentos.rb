class CreateDocumentos < ActiveRecord::Migration
  def self.up
    create_table :documentos do |t|
      t.string :tipo
      t.text :contenido
      t.integer :visita_id

      t.timestamps
    end
  end

  def self.down
    drop_table :documentos
  end
end
