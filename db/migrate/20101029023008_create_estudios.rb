class CreateEstudios < ActiveRecord::Migration
  def self.up
    create_table :estudios do |t|
      t.string :nombre, :null=>false
      t.decimal :arancel, :precision=>8, :scale=>2

      t.timestamps
    end
  end

  def self.down
    drop_table :estudios
  end
end
