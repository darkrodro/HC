class EstudiosController < ApplicationController
  layout "admin"
  
  # GET /estudios
  # GET /estudios.xml
  def index
    @estudios = Estudio.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @estudios }
    end
  end

  # GET /estudios/1
  # GET /estudios/1.xml
  def show
    @estudio = Estudio.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @estudio }
    end
  end

  # GET /estudios/new
  # GET /estudios/new.xml
  def new
    @estudio = Estudio.new

    respond_to do |format|
      format.xml  { render :xml => @estudio }
      format.js {render :form}
    end
  end

  # GET /estudios/1/edit
  def edit
    @estudio = Estudio.find(params[:id])

    respond_to do |format|
      format.js {render :form}
    end
  end

  # POST /estudios
  # POST /estudios.xml
  def create
    @estudio = Estudio.new(params[:estudio])

    respond_to do |format|
      if @estudio.save
        @class_index = 'new'
        format.js
      else
        format.js { render :form }
      end
    end
  end

  # PUT /estudios/1
  # PUT /estudios/1.xml
  def update
    @estudio = Estudio.find(params[:id])

    respond_to do |format|
      if @estudio.update_attributes(params[:estudio])
        format.js
      else
        format.js { render :form }
      end
    end
  end

  # DELETE /estudios/1
  # DELETE /estudios/1.xml
  def destroy
    @estudio = Estudio.find(params[:id])
    @estudio.destroy

    respond_to do |format|
      format.html { redirect_to(estudios_url) }
      format.xml  { head :ok }
    end
  end
end
