class GetDomainsService

  attr_reader :from, :to

  def initialize(from, to)
    @storage = RedisStorage.instance
    @from    = from.to_i
    @to      = to.to_i
  end

  def call
    return nil if from == 0 || to == 0
    domains_arr.flatten.uniq
  end

  private

  def domains_arr
    links_arrays.flatten.map do |links|
      JSON.parse(links).map do |link|
        URI(link).host || link
      end
    end
  end

  def links_arrays
    link_keys.flatten.map do |key|
      @storage.get(key)
    end
  end

  def link_keys
    (from..to).map do |time|
      @storage.keys.select{ |key| key.include?(time.to_s) }
    end
  end
end
