class Article
  include DataMapper::Resource

  property :id,       Serial
  property :source,   String
  property :time,     DateTime
  property :author,   String
  property :url,      Text
  property :category, String
  property :title,    String,  length: 255

  property :created_at, DateTime
  property :created_on, Date
  property :updated_at, DateTime
  property :updated_on, Date

  has n, :sentences
end
