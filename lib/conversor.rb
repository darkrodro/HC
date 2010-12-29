require 'kconv'

class Conversor
  
  def initialize
    @tabla = Hash.new
    @tabla[209] = "N" # Ñ
    @tabla[241] = "n" # ñ
    @tabla[193] = "A" # Á
    @tabla[192] = "A" # Á
    @tabla[196] = "A" # Á
    @tabla[224] = "a" # á
    @tabla[225] = "a" # á
    @tabla[161] = "i" # í
    @tabla[236] = "i" # í
    @tabla[237] = "i" # í
    @tabla[205] = "I" # Í
    @tabla[204] = "I" # Í
    @tabla[233] = "e" # é
    @tabla[201] = "E" # É
    @tabla[128] = "E" # É
    @tabla[200] = "E" # É
    @tabla[242] = "o" # ó
    @tabla[243] = "o" # ó
    @tabla[250] = "u" # ú
    @tabla[218] = "U" # Ú
    @tabla[217] = "U" # Ú
    @tabla[180] = "'" # ´
    @tabla[191] = "?" # ¿
    @tabla[168] = "?" # ¿
    @tabla[210] = "O" # Ó
    @tabla[211] = "O" # Ó
    @tabla[199] = "C" # Ç
    @tabla[186] = "" # º
    @tabla[176] = "" # |
    @tabla[170] = "" #   
    
  end
  
  def conv(str)
    return nil if str==nil
    
    res = ""
    str.to_s.each_byte do |b|
      if @tabla[b]
        res << @tabla[b]
      else
        res << b
      end
    end
    
   res
  end
end
