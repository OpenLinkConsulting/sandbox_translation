# This is the part of tranlation program

## Google autoML Translate Multi language Translation (ja/zh-TW/ko)

### How to run

1. First google credidential
2. ruby  proc_5a_table_translation_step3_translation_api_20210124.rb
   1. This is the translation of table
3. ruby proc_5b_step3_translation_api_20210124.rb
   1. This is the translation of main contents in the doc

### Input and Output

Data directory : test

1. Input directory
   1. in
      1. sample_1: yaml file for table translation -> proc_5a_table_translation_step3_translation_api_20210124.rb
      2. sample_2: yaml file for main part translation -> proc_5b_step3_translation_api_20210124.rb
2. Output Directory
   1. out
      1. sample_1: yaml file for table translation -> proc_5a_table_translation_step3_translation_api_20210124.rb
      2. sample_2: yaml file for main part translation -> proc_5b_step3_translation_api_20210124.rb

### Translation setting : project_id, location_id, model_id, and glossary if available

Japanese translation setting

```
# ## ja -------------------------------------------
target_lang = "ja"
project_id = "open-lc-g-signin"
source_language = "en"
location_id = "us-central1"
model_id = "NMc190444e7e1da849"
glossary_id = "edb_glossary_ja_v7"
# # -----------------------------------------------

## ja -　w/o model------------------------------------------
# target_lang = "ja"
# project_id = "open-lc-g-signin"
# source_language = "en"
# location_id = "us-central1"
# model_id = ""
# glossary_id = "edb_glossary_ja_v7"
# -----------------------------------------------


## zh-TW -----------------------------------------
# target_lang = "zh-TW"
# project_id = "open-lc-g-signin"
# source_language = "en"
# location_id = "us-central1"
# model_id = "NM9271e762e814d6a5"
# # model_id = "TRL8950902060375605248"
# glossary_id = "edb_glossary_tw_v4"
##   ----------------------------------------------

## ko ---------------------------------------------
# target_lang = "ko"
# project_id = "open-lc-g-signin"
# source_language = "en"
# location_id = "us-central1"
# model_id = ""
# glossary_id = "edb_glossary_ko_v1"
# -------------------------------------------------
```

### Program desctription of each

1. No need to run program proc_5a  hence commented out.
<!-- 1. proc_5a_table_translation_step3_translation_api_20210124.rb
   1. Translate the contents in the table section.
      1. Reason for having this:  Some columen does not require translation. Rather need to describe as is in English -->
2. proc_5b_step3_translation_api_20210124.rb
   1. Translation of main contents in yaml format
3. file_order_20190919.rb
   1. Sort the file in in/sample_1 and in/sample_2. So that file will be translated in the order
4. convert_to_number_and_back_to_japanese.rb
   1. This is to converst some words in a sentence that does not require tranlation that wrapped with "`" in the original md file.
      1. example: `postgreSQL` -> "no_tran_1" and back to `posrgresql` after translation process
      1. You can ignore this program when analysing the issue.


