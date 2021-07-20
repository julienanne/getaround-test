def execute(arguments)
  puts arguments[0]
end

if $0 == __FILE__
  execute(ARGV)
end
