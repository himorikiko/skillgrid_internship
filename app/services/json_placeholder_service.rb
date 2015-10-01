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
        raise Timeout::Error
      else
        get_responce = get_url("http://jsonplaceholder.typicode.com/photos/#{Random.rand(0..5000)}")
        image = JSON.parse(get_responce.body)
        if image['url'].split("/").last.to_i(16) > image['thumbnailUrl'].split("/").last.to_i(16)
          image['url']
        else
          AdministratorMailer.buy_error(current_user.email).deliver_later
          nil
        end
      end
    end

    def get_post current_user, photo_url
      begin
        tries ||= NUM_OF_TRIES
        delay = rand(MIN_DELAY..MAX_DELAY)
        sleep(delay)
        if delay > TIMEOUT_THRESHOULD
          raise Timeout::Error
        else
          post_responce = post_url("http://jsonplaceholder.typicode.com/todos")
          post = post_responce['id']

          AdministratorMailer.successfull_buy(post).deliver_later
          UserMailer.successfull_buy(current_user, photo_url).deliver_later

        end
      rescue => e
        unless (tries -= 1).zero?
          retry
        else
          raise Timeout::Error
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
