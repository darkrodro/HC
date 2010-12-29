class PacientesController < ApplicationController
  layout "paciente", :except=>[:show]
  
  # GET /pacientes
  # GET /pacientes.xml
  def index
    @pacientes = Paciente.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pacientes }
    end
  end

  # GET /pacientes/1
  # GET /pacientes/1.xml
  def show
    @paciente = Paciente.find(params[:id])

    respond_to do |format|
      format.html { render :layout=>"paciente_detalle"} # show.html.erb
      format.xml  { render :xml => @paciente }
    end
  end

  # GET /pacientes/new
  # GET /pacientes/new.xml
  def new
    @paciente = Paciente.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @paciente }
    end
  end

  # GET /pacientes/1/edit
  def edit
    @paciente = Paciente.find(params[:id])
  end

  # POST /pacientes
  # POST /pacientes.xml
  def create
    @paciente = Paciente.new(params[:paciente])

    respond_to do |format|
      if @paciente.save
        format.html { redirect_to(@paciente, :notice => 'El Paciente se creo exitosamente.') }
        format.xml  { render :xml => @paciente, :status => :created, :location => @paciente }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @paciente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pacientes/1
  # PUT /pacientes/1.xml
  def update
    @paciente = Paciente.find(params[:id])

    respond_to do |format|
      if @paciente.update_attributes(params[:paciente])
        format.html { redirect_to(@paciente, :notice => 'El Paciente se actualizo exitosamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @paciente.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /pacientes/buscar
  def buscar
    escaped_documento = escape(params[:documento])+'%'
    escaped_nombre = '%'+escape(params[:nombre])+'%'
    escaped_apellido = '%'+escape(params[:apellido])+'%'
    @pacientes = Paciente.find(:all, :conditions => ["documento like ? and nombre like ? and apellido like ?", escaped_documento, escaped_nombre, escaped_apellido])
    
    if @pacientes.count==1
      @paciente = @pacientes.first
      render :action=>:show, :layout=>"paciente_detalle"
    end
  end

  private
    def escape(text)
      text.gsub('%', '\%').gsub('_', '\_').gsub('\\', '\\\\')
    end
  
end
