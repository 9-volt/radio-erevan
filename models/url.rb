class URL
  include DataMapper::Resource

  property :id,         Serial
  property :url,        String,   unique: true, length: 255
  property :source,     String    # String for now, need to include the association
                                  # this is "unimedia", "jurnal", etc.
  property :parsed,     Boolean,  default: false, index: true
  property :error,      Boolean,  default: false

  property :created_at, DateTime
  property :created_on, Date
  property :updated_at, DateTime
  property :updated_on, Date
end
