require 'fileutils'

def execute
  actual_dir = File.expand_path(File.dirname(__FILE__))

  FileUtils.touch(File.join(actual_dir, 'data/output.json'))
end

if $0 == __FILE__
  execute
end
