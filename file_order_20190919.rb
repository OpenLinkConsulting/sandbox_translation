
require 'pry'
def file_order (file_input)
  @base = []
  @dir_base = []
  @file_name = []

    Dir.glob(file_input).each do|f|

           @base << File.basename(f)
           @file_name << File.basename(f,File.extname(f))
           # binding.pry
    end
    # binding.pry
   @base.sort!
   @file_name.sort!
end
