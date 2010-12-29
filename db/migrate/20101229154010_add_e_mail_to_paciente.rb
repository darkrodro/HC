class AddEMailToPaciente < ActiveRecord::Migration
  def self.up
    add_column :pacientes, :e_mail, :string
  end

  def self.down
    remove_column :pacientes, :e_mail
  end
end
