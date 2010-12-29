class EncabezadoYPieController < ApplicationController
  layout "admin"
  
  def show
    @eyp = EncabezadoYPie.get_instance
    respond_to do |format|
      format.html # index.html.erb
      format.pdf do
        docReport = DocumentoReport.new
        documento = Documento.new
        documento.visita = Visita.new
        documento.visita.fecha = Date.today
        documento.visita.paciente = Paciente.new
        documento.visita.paciente.nombre = "Nombre"
        documento.visita.paciente.apellido = "Apellido"
        documento.contenido = "contenido \n de \n prueba"
        
        output = docReport.generar(documento)
        send_data output, :filename => "prueba.pdf", 
                          :type => "application/pdf"
      end
    end
  end
  
  def update
    @eyp = EncabezadoYPie.get_instance
    @eyp.update_attributes(params[:encabezado_y_pie])
    @notice = 'Los datos se actualizaron exitosamente.'
    render :action=>:show
  end
  
end
