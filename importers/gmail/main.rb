require 'gmail'

class Importer::GMail
  attr_accessor :gmail

  def initialize(credentials)
    @gmail = Gmail.new(credentials[:username], credentials[:password])
  end
end