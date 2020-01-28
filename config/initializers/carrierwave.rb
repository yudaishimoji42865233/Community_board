require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAX2V5XW6AHDGU3K6S'
    aws_secret_access_key: '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'
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'yudaishimoji42865233'
  config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/yudaishimoji42865233'
end

