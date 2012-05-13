module SplashHelper
  def dev_mode
    "dev-mode" if ENV["RAILS_ENV"] == "development"
  end
end
