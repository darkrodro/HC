class CreateAnalisis < ActiveRecord::Migration
  def self.up
    create_table :analisis do |t|
      t.string :nombre, :null=>false
      t.decimal :arancel, :precision=>8, :scale=>2
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :analisis
  end
end
