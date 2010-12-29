class EvaluacionesController < ApplicationController
  layout "paciente_detalle"
  
  # GET /datosMedicos
  # GET /datosMedicos.xml
  def index
    
    @paciente = Paciente.find(params[:paciente_id])
    
    evaluaciones = Hash.new
    
    @paciente.evaluacion.each do |ev|
      evaluaciones[ev.dato_medico_id] = ev
    end
    
    @datos = Array.new
    
    DatoMedico.order(:position).each do |dm|
      ev = nil
      if evaluaciones[dm.id]
        ev = evaluaciones[dm.id]
      elsif dm.active?
        ev = Evaluacion.new
        ev.paciente = @paciente
        ev.dato_medico = dm
      end
      @datos.push(ev) if ev
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @datos }
    end
  end

  # POST /datosMedicos
  # POST /datosMedicos.xml
  def create
    @datoMedico = DatoMedico.new(params[:dato_medico])

    respond_to do |format|
      if @datoMedico.save
        @class_index = 'new'
        format.js
      else
        format.js { render :form }
      end
    end
  end

  # PUT /datosMedicos/1
  # PUT /datosMedicos/1.xml
  def update
      @evaluacion = @evaluacion = Evaluacion.find_or_create_by_paciente_id_and_dato_medico_id(params[:paciente_id], params[:dato_id]) 
      @evaluacion.valor = params[:valor]
    if !params[:valor].empty? && !params[:valor].blank?
      @evaluacion.save!
    else
      Evaluacion.where(:paciente_id=>params[:paciente_id], :dato_medico_id=>params[:dato_id]).delete_all if !@evaluacion.new_record?
    end
  end
end
