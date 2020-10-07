Devise.setup do |config|
  config.mailer_sender = 'rafflemania.help@gmail.com'
  config.mailer = 'UserMailer'
    config.reset_password_within = 6.hours
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.sign_out_via = :delete
  config.omniauth :amazon, ENV['AMAZON_CLIENT_ID'], ENV['AMAZON_CLIENT_SECRET'], {:scope => 'profile postal_code '}
end
