class Link
  attr_accessor :from, :to, :weight

  def initialize(from, to, weight)
    @from = from
    @to = to
    @weight = weight
  end
end