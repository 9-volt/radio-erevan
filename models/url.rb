class URL
  include DataMapper::Resource

  property :id,         Serial
  property :url,        String
  property :source,     String    # String for now, need to include the association
  property :parsed,     Boolean, default: false, index: true
end
