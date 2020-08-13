class SaveLinksService
  def initialize
    @storage = RedisStorage.instance
  end

  def call(links)
    return 'array is empty' if links.blank?
    @storage.save(time_stamp, links)
  end

  private

  def time_stamp
    Time.now.strftime("%Y%m%d%H%m%s")
  end
end

