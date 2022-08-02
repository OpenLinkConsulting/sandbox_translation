require 'net/http'
require 'uri'

require "google/cloud/translate"
require 'json'
require 'yaml'
require 'pry'
require_relative 'file_order_20190919.rb'
require_relative 'convert_to_number_and_back_to_japanese.rb'


@file_dir_hash = YAML.load_file("file_name.yaml", aliases: true)

client = Google::Cloud::Translate.translation_service


project_id = "#{@file_dir_hash['project_id']}"
target_language = "#{@file_dir_hash['target_language']}"
source_language = "#{@file_dir_hash['source_language']}"
location_id = "#{@file_dir_hash['location_id']}"
model_id = "#{@file_dir_hash['model_id']}"
glossary_id =  "#{@file_dir_hash['glossary_id']}"



model = "projects/#{project_id}/locations/#{location_id}/models/#{model_id}"
glossary_path = client.glossary_path project:  project_id,
                                     location: location_id,
                                     glossary: glossary_id
glossary_config = { glossary: glossary_path }
mime_type = "text/plain"
parent = client.location_path project: project_id, location: location_id

file_order ("#{@file_dir_hash['test_in_sample_1_dir']}/*.yaml")

s=""


@file_name.each do |item|

    file_out=File.open("#{@file_dir_hash['test_out_sample_1_dir']}/" + item +".yaml","w+")
    yaml = YAML.load_file("#{@file_dir_hash['test_in_sample_1_dir']}/" + item +".yaml", aliases: true)


    yaml.each{|k|
      # binding.pry
  
      k[:translated_text]=k[:table_hash]

        u  =  k[:table_hash][0].keys
      # binding.pry
  
        if  (u.include? "Description")|| (u.include? "Comment")|| (u.include? "Comments")|| (u.include? "Usage")|| (u.include? "**Description**") ||(u.include? "Action") ||(u.include? "**Comments**") ||(u.include? " Description")  ||(u.include? "**Behavior**")  ||(u.include? "Behavior") ||(u.include? "Information Monitored by Probe") || (u.include? "PEM Functionality Affected") || (u.include? "Specifies") || (u.include? "Notes") || (u.include? "Considerations")


        # binding.pry
  
        v =  u.find{|k| (k == "Description") or (k == "Comment") or (k == "Comments") or (k == "Usage") or (k == "**Description**") or (k == "Action") or (k == "**Comments**") or (k == " Description") or (k == "**Behavior**") or (k == "Behavior") or (k == "Information Monitored by Probe") or (k == "Information Monitored by Probe") or (k == "PEM Functionality Affected") or (k == "Specifies") or (k == "Notes") or (k == "Considerations")}



          # binding.pry
          for i in 0...(k[:table_hash].size) do
            k[:table_hash][i][v]

                  contents =[]
    
                  puts "----------------------------k[:table_hash][i][ #{v}]--------------------------"
        
                  puts k[:table_hash][i][v]

                  if k[:table_hash][i][v].empty?
                    k[:table_hash][i][v]="NA"
                  end

                  # binding.pry
                  convert_to_number k[:table_hash][i][v].to_s
        
                  puts "----------------------------k[:table_hash][i][ #{v}]--------------------------"
                  contents << @translation_output_english

                        unless model_id.empty?


                            # Translation engine  --------------------------------------------------
                                response = client.translate_text parent:               parent,
                                                                contents:             contents,
                                                                target_language_code: target_language,
                                                                source_language_code: source_language,
                                                                glossary_config:      glossary_config,
                                                                model:                model,
                                                                mime_type:            mime_type

                            # Translation engine  --------------------------------------------------

                          else
                            # Translation engine  --------------------------------------------------
                                response = client.translate_text parent:               parent,
                                                                contents:             contents,
                                                                target_language_code: target_language,
                                                                source_language_code: source_language,
                                                                glossary_config:      glossary_config,
                                                                # model:                model,
                                                                mime_type:            mime_type

                            # Translation engine  --------------------------------------------------


                          end



                  response.glossary_translations.each do |translation|

  

                      s = translation.translated_text.to_s

                      # binding.pry
                  end


                   puts convert_back_from_number s
                   # binding.pry
                   k[:translated_text][i][v] = @final_sentence_j.to_s

          end

    end
   
    }


        file_out.puts yaml.to_yaml

end
