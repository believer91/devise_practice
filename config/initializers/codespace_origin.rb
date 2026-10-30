if Rails.env.development? && ENV["CODESPACE_NAME"]
  class CodespaceOrigin
    def initialize(app)
      @app = app
    end

    def call(env)
      domain = ENV["GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN"]
      host = "#{ENV['CODESPACE_NAME']}-3000.#{domain}"

      if domain.present? &&
          env["HTTP_HOST"] == "localhost:3000" &&
          env["HTTP_X_FORWARDED_HOST"] == host &&
          env["HTTP_X_FORWARDED_PROTO"] == "https" &&
          env["HTTP_ORIGIN"] == "https://localhost:3000"
        env["HTTP_ORIGIN"] = "https://#{host}"
      end

      @app.call(env)
    end
  end

  Rails.application.config.middleware.use CodespaceOrigin
end