class AnalisisController < ApplicationController
  layout "admin"
  
  # GET /analisis
  # GET /analisis.xml
  def index
    @analisis = Analisis.all
    @analisis_eliminados= Analisis.unscoped.with_state(:deleted).order(:nombre)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @analisis }
    end
  end

  # GET /analisis/1
  # GET /analisis/1.xml
  def show
    @analisis = Analisis.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @analisis }
    end
  end

  # GET /analisis/new
  # GET /analisis/new.xml
  def new
    @analisis = Analisis.new

    respond_to do |format|
      format.xml  { render :xml => @analisis }
      format.js {render :form}
    end
  end

  # GET /analisis/1/edit
  def edit
    @analisis = Analisis.find(params[:id])

    respond_to do |format|
      format.js {render :form}
    end
  end

  # POST /analisis
  # POST /analisis.xml
  def create
    @analisis = Analisis.new(params[:analisis])

    respond_to do |format|
      if @analisis.save
        @class_index = 'new'
        format.js
      else
        format.js { render :form }
      end
    end
  end

  # PUT /analisis/1
  # PUT /analisis/1.xml
  def update
    @analisis = Analisis.find(params[:id])

    respond_to do |format|
      if @analisis.update_attributes(params[:analisis])
        format.js
      else
        format.js { render :form }
      end
    end
  end

  # DELETE /analisis/1
  # DELETE /analisis/1.xml
  def destroy
    @analisis = Analisis.find(params[:id])
    @analisis.destroy

    respond_to do |format|
      format.html { redirect_to(analisis_index_url) }
      format.xml  { head :ok }
    end
  end
  
  def restore
    @analisis = Analisis.unscoped.find(params[:id])
    @analisis.restore

    respond_to do |format|
      format.html { redirect_to(analisis_index_url) }
      format.xml  { head :ok }
    end
  end
  
end
