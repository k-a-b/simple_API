class RedisStorage
  include Singleton

  DB_NUMBER = 1
  DB_HOST   = 'localhost'.freeze
  DB_PORT   = 6379

  def initialize
    @redis ||= Redis.new(
                host: DB_HOST,
                port: DB_PORT,
                db: DB_NUMBER
              )
  end

  def save(key, value)
    @redis.set(key, value)
  end

  def keys
    @redis.keys
  end

  def get(key)
    @redis.get(key)
  end
end
