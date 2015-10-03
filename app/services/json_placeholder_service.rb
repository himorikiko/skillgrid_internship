class JsonPlaceholderService
  include HTTParty

  MIN_DELAY = 0
  MAX_DELAY = 6
  TIMEOUT_THRESHOULD = 3
  NUM_OF_TRIES = 3

  class << self
    def get_photo current_user
      delay = rand(MIN_DELAY..MAX_DELAY)
      sleep(delay)
      if delay > TIMEOUT_THRESHOULD
        Response.new.fail! ['Timeout error']
      else
        get_responce = get_url("http://jsonplaceholder.typicode.com/photos/#{Random.rand(0..5000)}")
        image = JSON.parse(get_responce.body)
        if image['url'].split("/").last.to_i(16) > image['thumbnailUrl'].split("/").last.to_i(16)
          Response.new.success! result: image['url']
        else
          Response.new.fail! ['thumbnailURL > url']
        end
      end
    end

    def get_post
      begin
        tries ||= NUM_OF_TRIES
        delay = rand(MIN_DELAY..MAX_DELAY)
        sleep(delay)
        if delay > TIMEOUT_THRESHOULD
          raise Timeout::Error
        else
          post_responce = post_url("http://jsonplaceholder.typicode.com/todos")
          post = post_responce['id']
          Response.new.success! result: post
        end
      rescue => e
        unless (tries -= 1).zero?
          retry
        else
          Response.new.fail! ['Timeout error']
        end
      end
    end

    private
      def get_url url
        HTTParty.get url
      end

      def post_url url
        HTTParty.post url
      end
  end
end
