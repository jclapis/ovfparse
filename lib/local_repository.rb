class LocalRepository < Repository

  def Repository.LSParse (raw_file_text) 
    file_list = Array.new 
    raw_file_text.each { |file_text|
      ALLOWABLE_TYPES.each { |type| 
        if file_text.include? type then
          fragment_arr = file_text.split(" ")
          file = fragment_arr.last
          file_list.push(file)
        end
      }
    }
    return file_list 
  end


  def fetch
      #retrieve data from file system 
      #if linux
      $cmd = "ls " + url
      #if windows
      #$cmd = "dir " + url

      pipe = IO.popen $cmd
      raw_file_list = pipe.read
      pipe.close

      #parse out package list
      #if linux 
      package_list = Repository::LSParse(raw_file_list)
      #if windows 
      #package_list = Repository::DIRParse(file_list)
    
      #construct package objects based on results
      return simplePackageConstruction(package_list)
  end
end
