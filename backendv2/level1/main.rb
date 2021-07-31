def execute
  File.open("path/to/file", "w") { |file| file.puts("lal") }
end

if $0 == __FILE__
  execute
end
