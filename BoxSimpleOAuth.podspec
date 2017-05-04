Pod::Spec.new do |s|
  s.name                  = 'BoxSimpleOAuth'
  s.version               = '0.2.0'
  s.summary               = 'A quick and simple way to authenticate a Box user in your iPhone or iPad app.'
  s.homepage              = 'https://github.com/rbaumbach/BoxSimpleOAuth'
  s.license               = { :type => 'MIT', :file => 'MIT-LICENSE.txt' }
  s.author                = { 'Ryan Baumbach' => 'github@ryan.codes' }
  s.source                = { :git => 'https://github.com/rbaumbach/BoxSimpleOAuth.git', :tag => s.version.to_s }
  s.requires_arc          = true
  s.platform              = :ios
  s.ios.deployment_target = '8.0'
  s.public_header_files   = 'BoxSimpleOAuth/Source/BoxSimpleOAuth.h',   'BoxSimpleOAuth/Source/BoxSimpleOAuthViewController.h',
                            'BoxSimpleOAuth/Source/BoxLoginResponse.h', 'BoxSimpleOAuth/Source/BoxAuthenticationManager.h'
  s.source_files          = 'BoxSimpleOAuth/Source/*.{h,m}'
  s.resources             = 'BoxSimpleOAuth/Source/*.xib'

  s.dependency 'SimpleOAuth2', '0.1.3'
  s.dependency 'MBProgressHUD', '>= 0.9'
end
