class VisitasController < ApplicationController
  layout "paciente_detalle"
  
  # GET /visitas
  # GET /visitas.xml
  def index
    @paciente = Paciente.find(params[:paciente_id])
    @visitas = @paciente.visitas

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @visitas }
    end
  end

  # GET /visitas/new
  # GET /visitas/new.xml
  def new
    @paciente = Paciente.find(params[:paciente_id])
    @visita = Visita.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @visita }
    end
  end

  # GET /visitas/1/edit
  def edit
    @paciente = Paciente.find(params[:paciente_id])
    @visita = Visita.find(params[:id])
  end

  # POST /visitas
  # POST /visitas.xml
  def create
    @paciente = Paciente.find(params[:paciente_id])
    @visita = Visita.new(params[:visita])
    @visita.paciente = @paciente

    respond_to do |format|
      if @visita.save
        format.html { redirect_to(paciente_visitas_url, :notice => 'La Visita se creo exitosamente.') }
        format.xml  { render :xml => @visita, :status => :created, :location => @visita }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @visita.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /visitas/1
  # PUT /visitas/1.xml
  def update
    @paciente = Paciente.find(params[:paciente_id])
    @visita = Visita.find(params[:id])

    respond_to do |format|
      if @visita.update_attributes(params[:visita])
        format.html { redirect_to(paciente_visitas_url, :notice => 'La Visita se modifico exitosamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @visita.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /visitas/1
  # DELETE /visitas/1.xml
  def destroy
    @visita = Visita.find(params[:id])
    @visita.destroy

    respond_to do |format|
      format.html { redirect_to(paciente_visitas_url) }
      format.xml  { head :ok }
    end
  end
end
