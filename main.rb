require "sinatra"
require "sidekiq"
require "redis"
require "sidekiq/api"
require "faraday"

$redis = Redis.new

class SinatraWorker
  include Sidekiq::Worker

  def perform
    resp = Faraday.get("https://www.vinomofo.com/api/v2/offers/search") do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Accept"] = "application/json"
    end

    puts "<== HERE ==>"
    puts resp
    puts JSON.parse(resp.body)
    puts "<== HERE ==>"

    $redis.lpush("sinkiq-example-messages", "Hallo, world!")
  end
end

post "/msg" do
  SinatraWorker.perform_async
end
