" Vim syntax file
" Language:           Ab Initio Data Manipulating Language
" Maintainer:         mattia72
" Version:            1.0
" Project Repository: https://github.com/mattia72/vim-abinitio
" Vim Script Page:    

if exists("b:current_syntax")
  finish
endif

syn cluster abNotTop contains=@abSpecial,abTodo

" Operators
syn match  abOperator "-=\|/=\|\*=\|&=\|&&\|/=\|||\|%=\|+=\|!\~\|!=\|=="
syn keyword abOperator or
syn keyword abOperator and
syn keyword abOperator not

syn match abSpecial  display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
syn match abSpecial  display contained '%\(?:\d+\$\)\?[dfsu]'


" Integer with - + or nothing in front
syn match abNumber '\d\+'
syn match abNumber '[-+]\d\+'
" Floating point number with decimal no E or e (+,-)
syn match abNumber '\d\+\.\d*'
syn match abNumber '[-+]\d\+\.\d*'
" Floating point like number with E and no decimal point (+,-)
syn match abNumber '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match abNumber '\d[[:digit:]]*[eE][\-+]\=\d\+'
" Floating point like number with E and decimal point (+,-)
syn match abNumber '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'
syn match abNumber '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'


syn region	abParen		transparent start='(' end=')' contains=ALLBUT,@Spell

"Variable is: name but not .name
syn match abVariable "^\<\h[a-zA-Z0-9#_]*\>"
syn match abVariable "[^.]\<\h[a-zA-Z0-9#_]*\>"ms=s+1
syn match abColumnName "\.\<\h[a-zA-Z0-9#_]*\>"ms=s+1

syn keyword abType vector type decimal float string date datetime int integer double short signed union unsigned 
syn keyword abType real long void skipwhite nextgroup=abParen

syn match abPort "\<\(in\|out\|error\|\(file\)*reject\|log\)\d*\>" 

syn keyword abLet let skipwhite nextgroup=abType

syn match  abUnionDef    "\<\(\[\s*union\|\]\)\>"
syn match  abRecordDef  "\<\(\[\s*record\|\]\)\>"
syn match  abVectorDef  "\<\(\[\s*vector\|\]\)\>"
syn match  abUnionType   "\<\(union\|end\)\>"
syn match  abRecordType "\<\(record\|end\)\>"
syn match  abVectorType "\<\(vector\|end\)\>"
syn match  abSwitchBlock     "\<\(switch\|end\)\>"
syn match  abBlock      "\<\(begin\|end\)\>"

syn keyword abConstant NULL

syn keyword abCodePage iso_8859_1 iso_8859_2 iso_8859_3 iso_8859_4 iso_8859_5 iso_8859_6 iso_8859_7 iso_8859_8 iso_8859_9 
syn keyword abCodePage iso_arabic iso_cyrillic iso_easteuropean iso_turkish iso_greek iso_hebrew iso_latin_1 iso_latin_2 iso_latin_3 iso_latin_4 jis_201
syn keyword abCodePage ascii ebcdic endian euc_jis ibm ieee unicode utf8 big little 

syn keyword abComponent reformat join rollup normalize denormalize scan 

syn keyword abConditional if else case default

syn keyword abRepeat while for do

syn keyword abKeyword _KEYTYPE_ constant delimiter 
syn keyword abKeyword member metadata package packed 

syn keyword abBuiltInFunc reformat first_defined reinterpret_as shift_jis 
syn keyword abBuiltInFunc this_record 

"Core functions
syn keyword abBuiltInFunc accumulation avg close_output concatenation copy_data count 
syn keyword abBuiltInFunc final_log_output first input_connected last log_error 
syn keyword abBuiltInFunc make_error max min  new_xml_doc output_connected output_for_error  
syn keyword abBuiltInFunc peek_object previous product read_byte read_object read_record 
syn keyword abBuiltInFunc read_string reject_data  set_starting_byte_offset stdev sum 
syn keyword abBuiltInFunc vector_concatenation write_data write_record write_string 
syn keyword abBuiltInFunc xml_add_attribute xml_add_cdata  xml_add_element  xml_begin_document  
syn keyword abBuiltInFunc xml_begin_element  xml_end_document xml_end_element xml_format  
syn keyword abBuiltInFunc xml_get_attribute xml_get_element xml_parse 
"String functions
syn keyword abBuiltInFunc char_string decimal_lpad decimal_lrepad decimal_strip edit_distance 
syn keyword abBuiltInFunc ends_with hamming_distance is_blank is_bzero make_byte_flags re_get_match 
syn keyword abBuiltInFunc re_get_matches re_get_matches re_index re_match_replace re_match_replace_all re_replace 
syn keyword abBuiltInFunc re_replace_first re_split re_split_no_empty starts_with string_char string_cleanse 
syn keyword abBuiltInFunc string_cleanse_euc_jp string_cleanse_shift_jis string_compare string_concat string_convert_explicit string_downcase 
syn keyword abBuiltInFunc string_filter string_filter_out string_from_hex string_han_to_zen_hiragana string_han_to_zen_katakana string_index 
syn keyword abBuiltInFunc string_is_alphabetic string_is_numeric string_join string_length string_like string_lpad 
syn keyword abBuiltInFunc string_lrepad string_lrtrim string_ltrim string_pad string_prefix string_repad 
syn keyword abBuiltInFunc string_replace string_replace_first string_rindex string_split string_split_no_empty string_substring 
syn keyword abBuiltInFunc string_split_quoted string_suffix string_to_hex string_trim string_truncate_explicit string_upcase 
syn keyword abBuiltInFunc test_characters_all test_characters_any to_json to_xml unicode_char_string url_decode_escapes 
syn keyword abBuiltInFunc url_encode_escapes 
"Date time functions
syn keyword abBuiltInFunc date_add_months date_day date_day_of_month date_day_of_week date_day_of_year date_difference_days 
syn keyword abBuiltInFunc date_difference_months date_month date_month_end date_to_int date_year datetime_add 
syn keyword abBuiltInFunc datetime_add_months datetime_change_zone datetime_day datetime_day_of_month datetime_day_of_week datetime_day_of_year 
syn keyword abBuiltInFunc datetime_difference datetime_difference_abs datetime_difference_days datetime_difference_hours datetime_difference_minutes datetime_difference_months 
syn keyword abBuiltInFunc datetime_difference_seconds datetime_from_390_tod datetime_from_unixtime datetime_hour datetime_microsecond datetime_minute 
syn keyword abBuiltInFunc datetime_month datetime_second datetime_to_unixtime datetime_year datetime_zone_offset decode_date 
syn keyword abBuiltInFunc decode_date_record decode_datetime decode_datetime_as_local encode_date encode_datetime encode_local_datetime 
syn keyword abBuiltInFunc local_now now now1 today today1 utc_now 
syn keyword abPreProc include 

syn keyword abTodo contained TODO FIXME NOTE
syn match abLineComment "//.*$" contains=abTodo

syn region abComment   matchgroup=abCommentStart start="/\*" end="\*/" contains=cCommentString,cCharacter,cNumbersCom,cSpaceError,@Spell fold extend

syn region  abString   start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=abSpecial,@Spell extend
syn region  abString   start=+L\='+ skip=+\\\\\|\\'+ end=+'+ contains=abSpecial,@Spell extend

syn region abVector matchgroup=abVectorDef start="\[\s*\<vector\>" end="\]" contains=ALLBUT,@abNotTop skipempty transparent fold
syn region abVector matchgroup=abVectorType start="\<vector\>" end="\<end\>" contains=ALLBUT,@abNotTop skipempty transparent fold
syn region abRecord matchgroup=abRecordDef start="\[\s*\<record\>" end="\]" contains=ALLBUT,@abNotTop skipempty transparent fold
syn region abRecord matchgroup=abRecordType start="\<record\>" end="\<end\>" contains=ALLBUT,@abNotTop skipempty transparent fold
syn region abSwitch matchgroup=abSwitchBlock start="\<switch\>" end="\<end\>" contains=ALLBUT,@abNotTop skipempty transparent fold
syn region abBeginEnd  matchgroup=abBlock start="\<begin\>" end="\<end\>" contains=ALLBUT,@abNotTop skipempty transparent fold 

syn sync fromstart

" highlight abKeywords guifg=blue
" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
if version >= 508 || !exists("did_abinitio_syntax_inits")
  if version < 508
    let did_abinitio_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink abTodo        Todo         
  HiLink abLineComment Comment      
  HiLink abComment     Comment      
  HiLink abCommentStart Comment      
  HiLink abKeywords    Statement    
  HiLink abBlock       PreProc
  HiLink abSwitchBlock Statement 
  HiLink abUnionDef     Structure 
  HiLink abUnionType    Type 
  HiLink abRecordDef   Structure 
  HiLink abRecordType  Type 
  HiLink abVectorDef   Structure 
  HiLink abVectorType  Type 
  HiLink abBuiltInFunc Function    
  HiLink abPort        Type
  HiLink abVariable    Normal    
  HiLink abColumnName  Identifier    
  HiLink abLet         Statement    
  HiLink abNumber      Constant     
  HiLink abOperator    Operator     
  HiLink abConditional Conditional
  HiLink abConstant    Constant
  HiLink abString      String       
  HiLink abRepeat      Repeat       
  HiLink abType        Type         
  HiLink abCodePage    Type         
  HiLink abPreProc     PreProc      
  HiLink abSpecial     SpecialChar
  delcommand HiLink
endif

let b:current_syntax = "abinitio"

" vim: ts=8
