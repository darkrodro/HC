# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101213154810) do

  create_table "analisis", :force => true do |t|
    t.string   "nombre",                                   :null => false
    t.decimal  "arancel",    :precision => 8, :scale => 2
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datos_medicos", :force => true do |t|
    t.string   "nombre",     :null => false
    t.string   "state"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documentos", :force => true do |t|
    t.string   "tipo"
    t.text     "contenido"
    t.integer  "visita_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "encabezado_y_pie", :force => true do |t|
    t.text     "encabezado"
    t.text     "pie"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estudios", :force => true do |t|
    t.string   "nombre",                                   :null => false
    t.decimal  "arancel",    :precision => 8, :scale => 2
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluaciones", :force => true do |t|
    t.integer  "paciente_id"
    t.integer  "dato_medico_id"
    t.string   "valor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "evaluaciones", ["paciente_id", "dato_medico_id"], :name => "index_evaluaciones_on_paciente_id_and_dato_medico_id", :unique => true

  create_table "pacientes", :force => true do |t|
    t.string   "nombre",             :null => false
    t.string   "apellido",           :null => false
    t.integer  "documento",          :null => false
    t.string   "sexo"
    t.date     "fecha_nacimiento"
    t.string   "telefono"
    t.string   "domicilio"
    t.string   "profesion"
    t.string   "obra_social",        :null => false
    t.string   "obra_social_numero"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visitas", :force => true do |t|
    t.date     "fecha"
    t.string   "ecg"
    t.string   "estado_actual"
    t.string   "rx_del_torax"
    t.string   "presion_arterial"
    t.string   "analisis"
    t.string   "pulso"
    t.string   "auscultacion"
    t.string   "otros_estudios"
    t.string   "aparato_respiratorio"
    t.string   "tratamiento"
    t.string   "otros_aparatos"
    t.string   "observaciones"
    t.integer  "paciente_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
