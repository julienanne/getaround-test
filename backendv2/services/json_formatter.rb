require 'json'

require_relative 'service'

class JsonFormatter < Service
  def initialize(hash_content:)
    @hash_content = hash_content
  end

  def call
    return JSON.generate(@hash_content,
    { indent: "  ", space: " ", array_nl: "\n", object_nl: "\n" })
  end
end
