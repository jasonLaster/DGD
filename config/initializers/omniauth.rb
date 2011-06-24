

Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :cas, {:cas_server => 'http://login.dartmouth.edu', :cas_login_url => 'http://login.dartmouth.edu/cas/login', :cas_service_validate_url => 'http://login.dartmouth.edu/cas/serviceValidate'}
end