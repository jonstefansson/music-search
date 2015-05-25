class Page
  attr_accessor :from, :size, :next

  def initialize(hash)
    @from = hash[:from].to_i
    @size = hash[:size].to_i
  end

  def calculate_next(hits)
    @next = @from + @size if @from + @size < hits
  end

  def has_next?
    self.next
  end
end