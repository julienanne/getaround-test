require 'json'

require_relative 'service'

class JsonReader < Service
  def initialize(input_file_path:)
    @input_file_path = input_file_path
  end

  def call
    JSON.parse(File.read(@input_file_path))
  end
end
