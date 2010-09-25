require 'rubygems'
require 'treetop'
require 'pp'
require 'ruby-debug'

Treetop.load File.join(File.dirname(__FILE__), "vim_parser_grammar")

def extract_tokens  tree
  tree.elements.compact.map do |el|
    if el.terminal? #&& el.elements.select { |a| a.nonterminal? }.empty?
      el.to_s
    else
      traverse el unless !el.elements
    end
  end.flatten.compact
end

def traverse  tree
  tree.elements.compact.map do |el|
    if el.terminal? #&& el.elements.select { |a| a.nonterminal? }.empty?
      el.to_s
    else
      traverse el unless !el.elements
    end
  end
end

def traverse_pp tree
  extract_tokens(tree)[0..-2]
end

#puts (traverse parsed).join(", ")
