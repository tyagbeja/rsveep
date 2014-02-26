CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => '',                       
    :aws_access_key_id      => '',    
    :aws_secret_access_key  => '',        
    :region                 => '',                  
    #:host                   => '',             # optional, defaults to nil
    #:endpoint               => '' # optional, defaults to nil
  }
  config.fog_directory  = ''                     # required
  #config.fog_public     = false                                   # optional, defaults to true
  #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end