require_relative 'application'

def execute(input_path = nil)
  Application.new(input_path).call
end

if $0 == __FILE__
  execute
end
