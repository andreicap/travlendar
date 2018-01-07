FactoryBot.define do
  factory :user do
    email         "test@test.com"
    password      "12345678"
    name          "John"
    token         "ya29.Gls7BWvUGS3ivb5xvk4kwSxj2-0cfRiG9Pkl_BCdKvqLwsItOcEpOfI1khCscazfnVLYqveWeZ9IpUiI7nIorYNJt5y06y4YdApjQsDm60y81UI0-NCcdQl3sglP"
    token_expiry  "018-01-07T15:01:15.742Z"
    refresh_token "1/veZKuubPKmfGHQk0xSbpvXbCRUBXlUjYPqINW-Nrji8jBGmacuCvnsT-VAnLbhws"
  end
end