require 'dbf'
require 'kconv'
require 'conversor'

ENV['dir'] = ENV['dir'] || "."

namespace :migracion do
  task :analisis => :environment do
    t = DBF::Table.new(ENV['dir']+"/neoana.dbf")
    Analisis.unscoped.delete_all
    counter = 0;
    t.each do |record|
      if record
        Analisis.create(:nombre=>record.estudio.capitalize, :arancel=>record.arancel)
        counter +=1
      end
    end
    puts "#{counter} analisis migrados"
  end
  
  task :estudios => :environment do
    t = DBF::Table.new(ENV['dir']+"/neoara.dbf")
    Estudio.unscoped.delete_all
    counter = 0;
    t.each do |record|
      if record
        Estudio.create(:nombre=>record.estudio.capitalize, :arancel=>record.arancel)
        counter +=1
      end
    end
    puts "#{counter} estudios migrados"
  end
  
  task :datos_medicos => :environment do
    t = DBF::Table.new(ENV['dir']+"/neohc.dbf")
    DatoMedico.unscoped.delete_all
    counter = 0;
    t.columns.each do |col|
      if counter > 7
        d = DatoMedico.create(:nombre=>col.name.humanize, :position=>counter)
        #d.position = counter
        #d.save
      end
      counter +=1
    end
    puts "#{counter-8} datos medicos migrados"
  end
  
  task :pacientes => :environment do
    
    start = Time.now
    
    tp = DBF::Table.new(ENV['dir']+"/neohc.dbf")
    tv = DBF::Table.new(ENV['dir']+"/neohc2.dbf")

    log = File.new(ENV['dir']+"/migracion.txt", "w")
    
    c = Conversor.new
    
    dms = DatoMedico.all
    
    Visita.delete_all
    Evaluacion.delete_all
    Paciente.delete_all
    
    counterP = 0;
    counterE = 0;
    counterV = 0;
    
    tp.each do |paciente|
      counterP +=1
      
      next if counterP<ENV['FROM'].to_i 
	  next unless paciente
      
      puts("#{counterP} - #{paciente.documento}")
      nya = c.conv(paciente.apellido)
      p = Paciente.new
      p.apellido = nya.slice!(/\S*\s/)
      if p.apellido == "de " || p.apellido == "del "
        p.apellido += nya.slice!(/\S*\s/)  
      end
      if p.apellido == "de la "
        p.apellido += nya.slice!(/\S*\s/)  
      end
      
      p.nombre = nya
      p.documento = paciente.documento
      p.sexo = case paciente.sexo
                  when "F"
                      "Femenino"
                  when "M"
                      "Masculino"
                  else
                      nil
                end
      p.fecha_nacimiento = paciente.fecha_nac
      p.telefono = paciente.telefono
      p.domicilio =  c.conv(paciente.domicilio)
      p.profesion = c.conv(paciente.trabajo)
      p.obra_social = paciente.institucio.empty? ? "Particular" : c.conv(paciente.institucio) 
      p.obra_social_numero = paciente.numero
      p.save
      
      if p.errors.include?(:documento)
        log.puts("\n")
        log.puts(p.inspect)
        log.puts("Documento #{p.errors[:documento][0]} -- Se agregan 0s al final.")
        while p.errors.include?(:documento)
          p.documento = "#{p.documento}0"
          p.save
        end
		log.puts "Nuevo documento: #{p.documento}"
      end
      
      if p.errors.include?(:apellido)
        log.puts("\n")
        log.puts(p.inspect)
        log.puts("Apellido #{p.errors[:apellido][0]} -- Se utilizo el nombre (#{p.nombre})")
        p.apellido = p.nombre
        p.save
      end
      
      if p.errors.count>0 then
          log.puts("\n")
          log.puts(p.inspect)
          p.errors.full_messages.each do |err|
            log.puts err
          end
          log.puts("No se pudo migrar")
      else
        dms.each do |dm|
          val = eval("paciente.#{dm.nombre.downcase.gsub(/ +/,'_')}")
          unless val==nil || val.to_s.empty? then
            ev = Evaluacion.new
            ev.paciente = p
            ev.dato_medico = dm
            ev.valor = c.conv(val)
            ev.save
            
            if ev.errors.count>0 then
              log.puts("\n")
              log.puts(p.documento)
              log.puts(dm.nombre)
              log.puts("-#{val}-")
              ev.errors.full_messages.each do |err|
                log.puts err
              end
              log.puts("No se pudo migrar")
            end
          end
        end
        tv.find(:all, :documento=>paciente.documento) do |visita|
          v = Visita.new
          v.paciente = p
          v.fecha = visita.fecha
          v.ecg = c.conv(visita.e_c_g_)
          v.estado_actual = c.conv(visita.estado_act)
          v.rx_del_torax = c.conv(visita.rx_t)
          v.presion_arterial = c.conv(visita.pres_art)
          v.analisis = c.conv(visita.analisis)
          v.pulso = c.conv(visita.pulso)
          v.auscultacion = c.conv(visita.ausc)
          v.otros_estudios = c.conv(visita.otros_est)
          v.aparato_respiratorio = c.conv(visita.aparato_r)
          v.tratamiento = c.conv(visita.tratamient)
          v.otros_aparatos = c.conv(visita.otros_apar)
          v.observaciones = c.conv(visita.observacio)
          
          v.save!
        end
      end
    end
    
    
    puts "Tardo #{Time.now - start} segundos"
  end
  
  task :todo do
    Rake::Task["migracion:analisis"].invoke
    Rake::Task["migracion:estudios"].invoke
    Rake::Task["migracion:datos_medicos"].invoke
    Rake::Task["migracion:pacientes"].invoke
  end
  
end