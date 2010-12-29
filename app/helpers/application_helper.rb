module ApplicationHelper
  
  def summarize(str, length=70)
    res = str.gsub("\n", " ")
    res = res[0..length]<<"..." if res.size>length
    
    res
  end
end
