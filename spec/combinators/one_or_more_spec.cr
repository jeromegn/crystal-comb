require "../spec_helper"

include Comb

describe Combinators::OneOrMore do
  x          = Combinators::OneOrMore.new(Base::Char.new('x'))
  y          = Combinators::OneOrMore.new(Base::Char.new('y'))
  empty      = Combinators::OneOrMore.new(Base::Empty.new)
  none       = Combinators::OneOrMore.new(Base::None.new)


  describe "#matches?" do
    it "returns true iff the string can be split into substrings that each are matched by the parser" do
      x.matches?("xxxx").should eq(true)
      y.matches?("xxxx").should eq(false)
      none.matches?("xxxx").should eq(false)

      x.matches?("x").should eq(true)
      y.matches?("x").should eq(false)
      none.matches?("x").should eq(false)

      x.matches?("").should eq(false)
      y.matches?("").should eq(false)
      none.matches?("").should eq(false)
    end
  end

  describe "#parse" do
    it "returns the set of matches for the parser as well as the empty string match" do
      x.parse("xxxx").results.should eq([{ "xxxx", "" }, { "xxx", "x" }, { "xx", "xx" }, { "x", "xxx" }])
      y.parse("xxxx").results.should eq([] of { String, String })
      none.parse("xxxx").results.should eq([] of { String, String })

      x.parse("x").results.should eq([{ "x", "" }])
      y.parse("x").results.should eq([] of { String, String })
      none.parse("x").results.should eq([] of { String, String })

      x.parse("").results.should eq([] of { String, String })
      y.parse("").results.should eq([] of { String, String })
      none.parse("").results.should eq([] of { String, String })
    end
  end
end