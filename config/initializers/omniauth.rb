Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cas, {
    :host => 'login.dartmouth.edu',
    :login_url => '/cas/login',
    :service_validate_url => '/cas/serviceValidate',
    :ssl => true
  }
end
