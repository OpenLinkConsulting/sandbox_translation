
require 'net/http'
require 'uri'
require 'googleauth'
require "google/cloud/translate"
require 'json'
require 'yaml'

s=""
t=""
u=""
v=""
contents = []
@hash_word ={}
@array = []
@hash_array ={}

def convert_to_number yaml_each_value

  no_translate_word = /\`.*?\`/
  link_quote = /\[.*?\]\(.*?\)/

  image = /^\!\[.*?\]\(.*?\)/
  list_item = /\n\s+\*\s/
  table_right_row = /^\|\s.*?\s+\|/
  attention_item = /^!!!\s.*+\n/
  sharp_mark = /#+/
  emphasis = /\*\*.*?\*\*/
  hyphen = /-\s/

  regexp = Regexp.union(no_translate_word,attention_item,link_quote,sharp_mark,hyphen)
  # binding.pry

      if yaml_each_value.match(regexp)


        @array= yaml_each_value.scan(regexp)


        n=0

        @hash_array = Hash[@array.map {|key, value| [value = "edb_tran_"+((n+=1).to_s), key]}]

        # binding.pry


        puts "------------------ output of array-----------------"
        p @array
        puts "------------------ end of output of array-----------------"
        puts ""

        puts "------------------ output of hash_array-----------------"
        puts @hash_array
        puts "------------------ end of output of hash_array-----------------"
        puts "------------------ output of hash_tran-----------------"
        puts @hash_tran = @hash_array.map{|key,value| [value, key]}.to_h
        puts "------------------ end of output of hash_tran-----------------"
        puts ""

         n = yaml_each_value.gsub!(/(\`.*?\`)|(\[.*?\]\(.*?\))/,@hash_tran)

         puts "-----------------yaml_each_value----------------"
         puts yaml_each_value
         puts "-----------------end of yaml_each_value----------------"
         puts ""

         puts "----------------- n ----------------"
         puts n
         puts "----------------- end of n ----------------"
         puts ""


    end
  @translation_output_english = yaml_each_value.to_s
# binding.pry

  return @translation_output_english
end

def convert_back_from_number translated_sentence

      if translated_sentence.to_s.scan(/edb_tran_(\d+)/).empty?
        @final_sentence_j=translated_sentence.to_s

      else

        @final_sentence_j = translated_sentence.to_s.gsub(/(edb_tran_(\d+))/,@hash_array).to_s
        puts "------------------------@final_sentence-------------------------"
        puts @final_sentence_j
        puts "------------------------end of @final_sentence-------------------------"
      end
    @hash_word = {}
    @array = []
    @hash_array ={}

    return @final_sentence_j.to_s
end
