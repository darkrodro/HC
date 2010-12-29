class DatosMedicosController < ApplicationController
  layout "admin"
  
  # GET /datosMedicos
  # GET /datosMedicos.xml
  def index
    @datosMedicos = DatoMedico.without_state(:deleted).order(:position)
    @datosMedicos_eliminados= DatoMedico.with_state(:deleted).order(:nombre)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @datosMedicos }
    end
  end

  # GET /datosMedicos/1
  # GET /datosMedicos/1.xml
  def show
    @datoMedico = DatoMedico.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @datoMedico }
    end
  end

  # GET /datosMedicos/new
  # GET /datosMedicos/new.xml
  def new
    @datoMedico = DatoMedico.new

    respond_to do |format|
      format.xml  { render :xml => @datoMedico }
      format.js {render :form}
    end
  end

  # GET /datosMedicos/1/edit
  def edit
    @datoMedico = DatoMedico.find(params[:id])

    respond_to do |format|
      format.js {render :form}
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
    @datoMedico = DatoMedico.find(params[:id])

    respond_to do |format|
      if @datoMedico.update_attributes(params[:dato_medico])
        format.js
      else
        format.js { render :form }
      end
    end
  end

  # DELETE /datosMedicos/1
  # DELETE /datosMedicos/1.xml
  def destroy
    @datoMedico = DatoMedico.find(params[:id])
    @datoMedico.destroy

    respond_to do |format|
      format.html { redirect_to(datos_medicos_url) }
      format.xml  { head :ok }
    end
  end
  
  def restore
    @datoMedico = DatoMedico.find(params[:id])
    @datoMedico.restore

    respond_to do |format|
      format.html { redirect_to(datos_medicos_url) }
      format.xml  { head :ok }
    end
  end
  
  def move_higher
    @datoMedico = DatoMedico.find(params[:id])
    @datoMedico.move_higher
    redirect_to :action=>:index
  end
  
  def move_to_top
    @datoMedico = DatoMedico.find(params[:id])
    @datoMedico.move_to_top
    redirect_to :action=>:index
  end
  
  def move_lower
    @datoMedico = DatoMedico.find(params[:id])
    @datoMedico.move_lower
    redirect_to :action=>:index
  end
  
  def move_to_bottom
    @datoMedico = DatoMedico.find(params[:id])
    @datoMedico.move_to_bottom
    redirect_to :action=>:index
  end
  
end
