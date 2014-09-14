#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.9
# from Racc grammer file "".
#

require 'racc/parser.rb'

require 'singleton'
require 'strscan'

module Namae
  class Parser < Racc::Parser

module_eval(<<'...end parser.y/module_eval...', 'parser.y', 104)

  include Singleton

  attr_reader :options, :input

  def initialize
    @input, @options = StringScanner.new(''), {
      :debug => false,
      :prefer_comma_as_separator => false,
      :comma => ',',
      :separator => /\s*(\band\b|\&)\s*/i,
      :title => /\s*\b(sir|lord|count(ess)?|(prof|dr|md|ph\.?d)\.?)(\s+|$)/i,
      :suffix => /\s*\b(JR|Jr|jr|SR|Sr|sr|[IVX]{2,})(\.|\b)/,
      :appellation => /\s*\b((mrs?|ms|fr|hr)\.?|miss|herr|frau)(\s+|$)/i
    }
  end

  def debug?
    options[:debug] || ENV['DEBUG']
  end

  def separator
    options[:separator]
  end

  def comma
    options[:comma]
  end

  def title
    options[:title]
  end

  def suffix
    options[:suffix]
  end

  def appellation
    options[:appellation]
  end

  def prefer_comma_as_separator?
    options[:prefer_comma_as_separator]
  end

  def parse(input)
    parse!(input)
  rescue => e
    warn e.message if debug?
    []
  end

  def parse!(string)
    input.string = normalize(string)
    reset
    do_parse
  end

  def normalize(string)
    string = string.strip
    string
  end

  def reset
    @commas, @words, @initials, @suffices, @yydebug = 0, 0, 0, 0, debug?
    self
  end

  private

  def stack
    @vstack || @racc_vstack || []
  end

  def last_token
    stack[-1]
  end

  def consume_separator
    return next_token if seen_separator?
    @commas, @words, @initials, @suffices = 0, 0, 0, 0
    [:AND, :AND]
  end

  def consume_comma
    @commas += 1
    [:COMMA, :COMMA]
  end

  def consume_word(type, word)
    @words += 1

    case type
    when :UWORD
      @initials += 1 if word =~ /^[[:upper:]]+\b/
    when :SUFFIX
      @suffices += 1
    end

    [type, word]
  end

  def seen_separator?
    !stack.empty? && last_token == :AND
  end

  def suffix?
    !@suffices.zero? || will_see_suffix?
  end

  def will_see_suffix?
    input.peek(8).to_s.strip.split(/\s+/)[0] =~ suffix
  end

  def will_see_initial?
    input.peek(6).to_s.strip.split(/\s+/)[0] =~ /^[[:upper:]]+\b/
  end

  def seen_full_name?
    prefer_comma_as_separator? && @words > 1 &&
      (@initials > 0 || !will_see_initial?) && !will_see_suffix?
  end

  def next_token
    case
    when input.nil?, input.eos?
      nil
    when input.scan(separator)
      consume_separator
    when input.scan(/\s*,\s*/)
      if @commas.zero? && !seen_full_name? || @commas == 1 && suffix?
        consume_comma
      else
        consume_separator
      end
    when input.scan(/\s+/)
      next_token
    when input.scan(title)
      consume_word(:TITLE, input.matched.strip)
    when input.scan(suffix)
      consume_word(:SUFFIX, input.matched.strip)
    when input.scan(appellation)
      [:APPELLATION, input.matched.strip]
    when input.scan(/((\\\w+)?\{[^\}]*\})*[[:upper:]][^\s#{comma}]*/)
      consume_word(:UWORD, input.matched)
    when input.scan(/((\\\w+)?\{[^\}]*\})*[[:lower:]][^\s#{comma}]*/)
      consume_word(:LWORD, input.matched)
    when input.scan(/(\\\w+)?\{[^\}]*\}[^\s#{comma}]*/)
      consume_word(:PWORD, input.matched)
    when input.scan(/('[^'\n]+')|("[^"\n]+")/)
      consume_word(:NICK, input.matched[1...-1])
    else
      raise ArgumentError,
        "Failed to parse name #{input.string.inspect}: unmatched data at offset #{input.pos}"
    end
  end

  def on_error(tid, value, stack)
    raise ArgumentError,
      "Failed to parse name: unexpected '#{value}' at #{stack.inspect}"
  end

# -*- racc -*-
...end parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
   -39,    30,    46,    31,   -40,    16,    61,   -39,    66,   -39,
   -39,   -40,    17,   -40,   -40,    32,    59,    65,    53,    52,
    54,    53,    52,    54,   -22,   -34,   -22,   -38,    39,   -22,
    33,   -22,   -22,    59,   -38,    53,    52,    54,    30,   -22,
    31,    67,    39,    53,    52,    54,    14,    12,    15,    58,
    39,     7,     8,    14,    12,    15,    39,    45,     7,     8,
    14,    22,    15,    24,    14,    22,    15,    24,    30,    28,
    31,    53,    52,    54,    30,    28,    31,    30,    42,    31,
    53,    52,    54,    30,    28,    31,    14,    22,    15,   -19,
   -19,   -19,    30,    28,    31,    30,    28,    31,    59,    39 ]

racc_action_check = [
    14,    29,    29,    29,    15,     1,    44,    14,    50,    14,
    14,    15,     1,    15,    15,    11,    50,    49,    49,    49,
    49,    45,    45,    45,    28,    49,    28,    12,    45,    12,
    16,    28,    42,    38,    12,    61,    61,    61,    43,    42,
    43,    57,    61,    32,    32,    32,     0,     0,     0,    37,
    32,     0,     0,    17,    17,    17,    63,    27,    17,    17,
     9,     9,     9,     9,    20,    20,    20,    20,    25,    25,
    25,    66,    66,    66,    21,    21,    21,    24,    24,    24,
    70,    70,    70,    35,    35,    35,     5,     5,     5,    22,
    22,    22,    10,    10,    10,    41,    41,    41,    69,    23 ]

racc_action_pointer = [
    43,     5,   nil,   nil,   nil,    83,   nil,   nil,   nil,    57,
    89,    13,    27,   nil,     0,     4,    30,    50,   nil,   nil,
    61,    71,    86,    89,    74,    65,   nil,    55,    24,    -2,
   nil,   nil,    40,   nil,   nil,    80,   nil,    40,    23,   nil,
   nil,    92,    32,    35,     4,    18,   nil,   nil,   nil,    15,
     6,   nil,   nil,   nil,   nil,   nil,   nil,    32,   nil,   nil,
   nil,    32,   nil,    46,   nil,   nil,    68,   nil,   nil,    88,
    77 ]

racc_action_default = [
    -1,   -49,    -2,    -4,    -5,   -49,    -8,    -9,   -10,   -23,
   -49,   -49,   -19,   -28,   -30,   -31,   -49,   -49,    -6,    -7,
   -49,   -49,   -38,   -41,   -49,   -49,   -29,   -15,   -20,   -23,
   -30,   -31,   -36,    71,    -3,   -49,   -15,   -45,   -42,   -43,
   -12,   -49,   -19,   -23,   -14,   -36,   -21,   -16,   -24,   -37,
   -26,   -32,   -38,   -39,   -40,   -14,   -11,   -46,   -47,   -44,
   -13,   -36,   -17,   -49,   -33,   -35,   -49,   -48,   -18,   -25,
   -27 ]

racc_goto_table = [
     3,    38,    26,    47,    27,    18,     9,     1,     2,    23,
    56,    20,    70,    26,    63,    36,    62,     3,    40,    44,
    23,    37,    26,     9,    21,    34,    19,    57,    25,    55,
    43,   nil,    68,   nil,   nil,    60,    26,   nil,   nil,    35,
   nil,    69,   nil,    41,   nil,   nil,   nil,   nil,   nil,    64,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
    64 ]

racc_goto_check = [
     3,    16,    17,    12,    10,     3,     7,     1,     2,     3,
     9,     7,    14,    17,    15,    10,    12,     3,    10,    10,
     3,     8,    17,     7,    11,     2,     4,    18,    11,    10,
     7,   nil,    12,   nil,   nil,    10,    17,   nil,   nil,    11,
   nil,    16,   nil,    11,   nil,   nil,   nil,   nil,   nil,     3,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
     3 ]

racc_goto_pointer = [
   nil,     7,     8,     0,    21,   nil,   nil,     6,    -2,   -27,
    -6,    19,   -29,   nil,   -54,   -35,   -22,    -7,   -10 ]

racc_goto_default = [
   nil,   nil,   nil,    51,     4,     5,     6,    29,   nil,   nil,
    11,    10,   nil,    48,    49,   nil,    50,    13,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  0, 12, :_reduce_1,
  1, 12, :_reduce_2,
  3, 12, :_reduce_3,
  1, 13, :_reduce_4,
  1, 13, :_reduce_none,
  2, 13, :_reduce_6,
  2, 13, :_reduce_7,
  1, 13, :_reduce_none,
  1, 16, :_reduce_9,
  1, 16, :_reduce_10,
  4, 15, :_reduce_11,
  3, 15, :_reduce_12,
  4, 15, :_reduce_13,
  3, 15, :_reduce_14,
  2, 15, :_reduce_15,
  3, 17, :_reduce_16,
  4, 17, :_reduce_17,
  5, 17, :_reduce_18,
  1, 22, :_reduce_none,
  2, 22, :_reduce_20,
  3, 22, :_reduce_21,
  1, 21, :_reduce_none,
  1, 21, :_reduce_none,
  1, 23, :_reduce_24,
  3, 23, :_reduce_25,
  1, 23, :_reduce_26,
  3, 23, :_reduce_27,
  1, 18, :_reduce_none,
  2, 18, :_reduce_29,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  1, 25, :_reduce_none,
  2, 25, :_reduce_33,
  0, 26, :_reduce_none,
  1, 26, :_reduce_none,
  0, 24, :_reduce_none,
  1, 24, :_reduce_none,
  1, 14, :_reduce_none,
  1, 14, :_reduce_none,
  1, 14, :_reduce_none,
  0, 19, :_reduce_none,
  1, 19, :_reduce_none,
  1, 27, :_reduce_none,
  2, 27, :_reduce_44,
  0, 20, :_reduce_none,
  1, 20, :_reduce_none,
  1, 29, :_reduce_none,
  2, 29, :_reduce_48 ]

racc_reduce_n = 49

racc_shift_n = 71

racc_token_table = {
  false => 0,
  :error => 1,
  :COMMA => 2,
  :UWORD => 3,
  :LWORD => 4,
  :PWORD => 5,
  :NICK => 6,
  :AND => 7,
  :APPELLATION => 8,
  :TITLE => 9,
  :SUFFIX => 10 }

racc_nt_base = 11

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "COMMA",
  "UWORD",
  "LWORD",
  "PWORD",
  "NICK",
  "AND",
  "APPELLATION",
  "TITLE",
  "SUFFIX",
  "$start",
  "names",
  "name",
  "word",
  "display_order",
  "honorific",
  "sort_order",
  "u_words",
  "opt_suffices",
  "opt_titles",
  "last",
  "von",
  "first",
  "opt_words",
  "words",
  "opt_comma",
  "suffices",
  "u_word",
  "titles" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'parser.y', 11)
  def _reduce_1(val, _values, result)
     result = [] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 12)
  def _reduce_2(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 13)
  def _reduce_3(val, _values, result)
     result = val[0] << val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 15)
  def _reduce_4(val, _values, result)
     result = Name.new(:given => val[0]) 
    result
  end
.,.,

# reduce 5 omitted

module_eval(<<'.,.,', 'parser.y', 17)
  def _reduce_6(val, _values, result)
     result = val[0].merge(:family => val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 18)
  def _reduce_7(val, _values, result)
     result = val[1].merge(val[0]) 
    result
  end
.,.,

# reduce 8 omitted

module_eval(<<'.,.,', 'parser.y', 21)
  def _reduce_9(val, _values, result)
     result = Name.new(:appellation => val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 22)
  def _reduce_10(val, _values, result)
     result = Name.new(:title => val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 26)
  def _reduce_11(val, _values, result)
             result = Name.new(:given => val[0], :family => val[1], :suffix => val[2], :title => val[3])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 30)
  def _reduce_12(val, _values, result)
             result = Name.new(:given => val[0], :nick => val[1], :family => val[2])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 34)
  def _reduce_13(val, _values, result)
             result = Name.new(:given => val[0], :nick => val[1],
           :particle => val[2], :family => val[3])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 39)
  def _reduce_14(val, _values, result)
             result = Name.new(:given => val[0], :particle => val[1],
          :family => val[2])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 44)
  def _reduce_15(val, _values, result)
             result = Name.new(:particle => val[0], :family => val[1])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 49)
  def _reduce_16(val, _values, result)
             result = Name.new({ :family => val[0], :suffix => val[2][0],
           :given => val[2][1] }, !!val[2][0])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 54)
  def _reduce_17(val, _values, result)
             result = Name.new({ :particle => val[0], :family => val[1],
           :suffix => val[3][0], :given => val[3][1] }, !!val[3][0])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 59)
  def _reduce_18(val, _values, result)
             result = Name.new({ :particle => val[0,2].join(' '), :family => val[2],
           :suffix => val[4][0], :given => val[4][1] }, !!val[4][0])
       
    result
  end
.,.,

# reduce 19 omitted

module_eval(<<'.,.,', 'parser.y', 65)
  def _reduce_20(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 66)
  def _reduce_21(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 22 omitted

# reduce 23 omitted

module_eval(<<'.,.,', 'parser.y', 70)
  def _reduce_24(val, _values, result)
     result = [nil,val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 71)
  def _reduce_25(val, _values, result)
     result = [val[2],val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 72)
  def _reduce_26(val, _values, result)
     result = [val[0],nil] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 73)
  def _reduce_27(val, _values, result)
     result = [val[0],val[2]] 
    result
  end
.,.,

# reduce 28 omitted

module_eval(<<'.,.,', 'parser.y', 76)
  def _reduce_29(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 30 omitted

# reduce 31 omitted

# reduce 32 omitted

module_eval(<<'.,.,', 'parser.y', 81)
  def _reduce_33(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 34 omitted

# reduce 35 omitted

# reduce 36 omitted

# reduce 37 omitted

# reduce 38 omitted

# reduce 39 omitted

# reduce 40 omitted

# reduce 41 omitted

# reduce 42 omitted

# reduce 43 omitted

module_eval(<<'.,.,', 'parser.y', 91)
  def _reduce_44(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 45 omitted

# reduce 46 omitted

# reduce 47 omitted

module_eval(<<'.,.,', 'parser.y', 96)
  def _reduce_48(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module Namae
