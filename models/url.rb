class URL
  include DataMapper::Resource

  property :id,         Serial
  property :url,        String,   unique: true
  property :source,     String    # String for now, need to include the association
                                  # this is "unimedia", "jurnal", etc.
  property :parsed,     Boolean,  default: false, index: true
  property :error,      Boolean,  default: false
end
