class Hash
  def modify_values(&block)
    self.dup.inject({}) { |h, (k, v)| h[k] = block.call(v); h }
  end
end
