class DocumentoReport < Prawn::Document
  
  def generar(documento)
    eyp = EncabezadoYPie.get_instance
    
    
    image "#{RAILS_ROOT}/public/images/logo.png", :height=>100, :position=>:center
    
    move_down 20
    
    text_html eyp.encabezado
    
    move_down(20)
    
    visita = documento.visita
    paciente = visita.paciente
      
    str = "<b>#{paciente.sexo=="Femenino"? "Sra." : "Sr."}</b> #{paciente.apellido}, #{paciente.nombre}"
    text str, :inline_format=>true     
    
    str = "<b>Obra social:</b> #{paciente.obra_social}"
    str += " <b>- Nro.:</b> #{paciente.obra_social_numero}" if paciente.obra_social_numero && !paciente.obra_social_numero.empty? 
    text str, :inline_format=>true
      
    str = "<b>Fecha:</b> #{visita.fecha}"
    text str, :inline_format=>true
      
    move_down(20)  
    
    indent(20) do  
      text documento.contenido
    end
    
    move_cursor_to(100)
    
    text_html eyp.pie
    
    render
  end
  
  def text_html(body)
    html = Nokogiri::HTML.parse(body)
    
    html.xpath('//font').each do |font|
      if font.attributes["size"] != nil
        font.attributes["size"].value = case font.attributes["size"].value
                                            when "1"
                                               "10"
                                            when "2"
                                               "12"
                                            when "3"
                                               "14"
                                            when "4"
                                               "18"
                                            when "5"
                                               "24"
                                            when "6"
                                               "36"
                                            when "7"
                                               "54"
                                        end
      end
    end
    
    html = html.children[1].children[0] # html/body
    
    html.children.each do |elem|
      if(elem.name == "p") then
        align = :left
        if elem.attributes["align"]
          align = case elem.attributes["align"].value 
                    when "center"
                      :center
                    when "right"
                      :right 
                    when "full"
                      :justify
                    else
                       :left
                 end
        end
        str =  elem.children.to_s
        str.gsub!("&nbsp;", "\xC2\xA0")
        text str, :inline_format=>true, :align=>align.to_sym
      else
        str =  elem.to_s
        str.gsub!("&nbsp;", "\xC2\xA0")
        text str, :inline_format=>true
      end
      
    end
  end
end
