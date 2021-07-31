require_relative 'service'

class JsonWriter < Service
  def initialize(output_file_path:, json_content:)
    @output_file_path = output_file_path
    @json_content = json_content
  end

  def call
    File.open(@output_file_path, "w") do |file|
      file.puts(@json_content)
    end
  end
end
