class Movement < Treetop::Runtime::SyntaxNode
  def eval
    "MVMT #{text_value}"
  end

  def to_s
    dir = case text_value
      when "j"
        "down"
      when "k"
        "up"
      when "h"
        "left"
      when "l"
        "right"
      end

    "move #{dir}"
  end
end
