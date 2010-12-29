class DocumentosController < ApplicationController
  
  # GET ......./documento/1.pdf
  def show
    documento = Documento.find(params[:id])
    docReport = DocumentoReport.new
    output = docReport.generar(documento)

    respond_to do |format|
      format.pdf do
        send_data output, :filename => "#{documento.tipo}.pdf", 
                          :type => "application/pdf"
      end
    end

    
  end

  # GET ......./documentos/new
  # GET ......./documentos/new.xml
  def new
    @documento = Documento.new
    @documento.tipo = "receta"
    @visita = Visita.find(params[:visita_id])
    @paciente = @visita.paciente
    
    @analisis = Analisis.all
    @estudios = Estudio.all

    respond_to do |format|
      format.js {render :form}
    end
  end

  # POST /pacientes
  # POST /pacientes.xml
  def create
    @documento = Documento.new(params[:documento])
    @visita = Visita.find(params[:visita_id])
    @documento.visita = @visita

    @paciente = @visita.paciente

    respond_to do |format|
      if @documento.save
        format.js 
      else
        @analisis = Analisis.all
	  @estudios = Estudio.all	
        format.js { render :form }
      end
    end
  end

  # DELETE ...../documentos/1
  # DELETE ...../documentos/1.xml
  def destroy
    @documento = Documento.find(params[:id])
    @documento.destroy

    respond_to do |format|
      format.html { redirect_to(paciente_visitas_url) }
      format.xml  { head :ok }
    end
  end
end
