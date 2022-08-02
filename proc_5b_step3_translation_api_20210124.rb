require 'net/http'
require 'uri'

require "google/cloud/translate"
require 'json'
require 'yaml'
require_relative 'file_order_20190919.rb'
require_relative 'convert_to_number_and_back_to_japanese.rb'

# 本文の翻訳を行うメインのコンポーネント

@file_dir_hash = YAML.load_file("file_name.yaml", aliases: true)

client = Google::Cloud::Translate.translation_service

project_id = "#{@file_dir_hash['project_id']}"
target_language = "#{@file_dir_hash['target_language']}"
source_language = "#{@file_dir_hash['source_language']}"
location_id = "#{@file_dir_hash['location_id']}"
model_id = "#{@file_dir_hash['model_id']}"
glossary_id =  "#{@file_dir_hash['glossary_id']}"


# project_id = "open-lc-g-signin"
# target_language = "ja"
# source_language = "en"
# location_id = "us-central1"
# model_id = "TRL5657739390860918784"


model = "projects/#{project_id}/locations/#{location_id}/models/#{model_id}"
glossary_path = client.glossary_path project:  project_id,
                                     location: location_id,
                                     glossary: glossary_id
glossary_config = { glossary: glossary_path }
mime_type = "text/plain"
parent = client.location_path project: project_id, location: location_id

file_order ("#{@file_dir_hash['working_sub_translation_before_transl_contents_directory']}/*.yaml")
s=""


@file_name.each do |item|

    file_out=File.open("#{@file_dir_hash['translated_sub_yml_directory']}/" + item +".yaml","w+")

    yaml = YAML.load_file("#{@file_dir_hash['working_sub_translation_before_transl_contents_directory']}/" + item +".yaml", aliases: true)


    yaml.each{|k|

        contents =[]

        puts "----------------------------k[:contents]--------------------------"
        puts k[:contents]
  
        convert_to_number k[:contents].to_s
        puts "----------------------------k[:contents]--------------------------"
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

        end


         puts convert_back_from_number s

        k[:translated_contents]= @final_sentence_j


        }
        file_out.puts yaml.to_yaml

end
