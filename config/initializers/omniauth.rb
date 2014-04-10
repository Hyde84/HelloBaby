Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '291451477677860', '62098b9ad441d8eca4e6aa24f303a9a3'
end