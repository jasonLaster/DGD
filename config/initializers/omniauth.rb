

Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :cas, {
    :cas_server => 'https://login.dartmouth.edu', 
    :cas_login_url => 'https://login.dartmouth.edu/cas/login', 
    :cas_service_validate_url => 'https://login.dartmouth.edu/cas/serviceValidate'
  }
end