module Cmor
  module Cms
    class RedirectMiddleware
      def initialize(app)
        @app = app
      end

      def redirect_to(location)
        [301, {'Location' => location, 'Content-Type' => 'text/html'}, ['Moved Permanently']]
      end

      def call(env)
        req = Rack::Request.new(env)
        if redirect = find_redirect_for(req.path)
          return redirect_to(redirect.target)
        end
        @app.call(env)
      end

      def find_redirect_for(request_path)
        Cmor::Cms::Redirect.published.where(source: request_path).first
      end
      # def call(env)
      #   req = Rack::Request.new(env)
      #   return redirect(redirects[req.path]) if redirects.include?(req.path)
      #   @app.call(env)
      # end

      # def redirects
      #   { '/source' => '/target' }
      # end
    end
  end
end
