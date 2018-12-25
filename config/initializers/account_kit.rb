AccountKit.configure do |config|
  config.app_id      = Rails.application.credentials.account_kit[:app_id]
  config.app_secret  = Rails.application.credentials.account_kit[:app_secret]
  config.api_version = 'v1.1'
end
