require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')
require 'lib/vim_parser'

describe VimGrammarParser do
  before(:all) do 
    @parser = VimGrammarParser.new
  end

  it "emits 'move down' for 'j'" do
    parsed = (@parser.parse 'j')

    (traverse_pp parsed).should == ["move down"]
  end

  it "emits 'move down' and 'move up' for 'jk'" do
    parsed = (@parser.parse 'jk')
    traversed = traverse_pp(parsed)

    traversed.should == ["move down", "move up"]
  end

  it "handles repititions" do
    parsed = (@parser.parse 'jjj')
    traversed = traverse_pp(parsed)

    traversed.should == ["move down", "move down", "move down"]
  end

  it "handles varying directions" do
    parsed = (@parser.parse 'hjkl')

    (traverse_pp parsed).should == ["move left", "move down", "move up", "move right"]
  end

  it "handles 'dd'" do
    (traverse_pp @parser.parse 'dd').should == ["delete line"]
  end

  describe "count commands" do
    it "emits 'move down 2 times' for '2j'" do
      (traverse_pp @parser.parse '2j').should == ["2 times", "move down"]
    end

  end

  describe "insert mode" do
    it "emits 'inserted: 'abc'' for 'iabc<ESC>'" do
      (traverse_pp @parser.parse 'iabc<ESC>').should == ["enter insert mode (i)", "a", "b", "c", "leave insert mode"]
    end

    it "emits 'enter insert with append (a) for 'aabc<ESC>'" do
      (traverse_pp @parser.parse 'aabc<ESC>').should == ["enter insert with append (a)", "a", "b", "c", "leave insert mode"]
    end

    it "should handle insert mode in concert with other commands" do

      (traverse_pp @parser.parse '3jihello<ESC>kdd').should_not be_nil
    end
  end
end
