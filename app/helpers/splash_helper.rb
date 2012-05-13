module SplashHelper
  def dev_mode
    "dev-mode" if Rails.env.development?
  end
end
