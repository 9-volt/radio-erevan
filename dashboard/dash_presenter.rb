class DashPresenter
  attr_reader :urls

  def initialize
    @urls = URL.all
  end

  def all
    urls.count
  end

  def parsed
    urls.count(parsed: true)
  end

  def parsed_percentage
    parsed / all.to_f * 100
  end

  def per_source
    Hash[*URL.aggregate(:source, :all.count).flatten]
  end

  def per_source_parsed
    Hash[*URL.aggregate(:source, :all.count, conditions: ['parsed = ?', true]).flatten]
  end

  def per_source_today
    data = URL.all(:updated_on.gt => Date.today - 1, :parsed => true)
              .aggregate(:source, :all.count)
    Hash[*data]
  end
end

