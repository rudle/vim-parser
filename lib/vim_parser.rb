require 'rubygems'
require 'treetop'
require 'pp'
require 'ruby-debug'

Treetop.load File.join(File.dirname(__FILE__), "vim_parser_grammar")

def traverse  tree
  return nil if tree.elements.nil?

  tree.elements.compact.map do |el|
    if el.terminal?
      el.to_s
    else
      traverse el
    end
  end.flatten.compact
end

def traverse_pp tree
  traverse(tree)[0..-2]
end

#puts (traverse parsed).join(", ")
