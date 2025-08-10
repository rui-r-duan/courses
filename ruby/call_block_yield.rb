def call_block
  yield
end

def pass_block(&block)
  call_block(&block)
end
