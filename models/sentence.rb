require 'json'

class Sentence
  include DataMapper::Resource

  property :id,           Serial
  property :text,         Text
  property :parsed_text,  String

  belongs_to :article
end
