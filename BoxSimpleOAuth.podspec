Pod::Spec.new do |s|
  s.name                  = 'BoxSimpleOAuth'
  s.version               = '0.1.1'
  s.summary               = 'A quick and simple way to authenticate a Box user in your iPhone or iPad app.'
  s.homepage              = 'https://github.com/rbaumbach/BoxSimpleOAuth'
  s.license               = { :type => 'MIT', :file => 'MIT-LICENSE.txt' }
  s.author                = { 'Ryan Baumbach' => 'rbaumbach.github@gmail.com' }
  s.source                = { :git => 'https://github.com/rbaumbach/BoxSimpleOAuth.git', :tag => s.version.to_s }
  s.requires_arc          = true
  s.platform              = :ios
  s.ios.deployment_target = '7.0'
  s.public_header_files   = 'BoxSimpleOAuth/Source/BoxSimpleOAuth.h',   'BoxSimpleOAuth/Source/BoxSimpleOAuthViewController.h',
                            'BoxSimpleOAuth/Source/BoxLoginResponse.h', 'BoxSimpleOAuth/Source/BoxAuthenticationManager.h'
  s.source_files          = 'BoxSimpleOAuth/Source/*.{h,m}'
  s.resources             = 'BoxSimpleOAuth/Source/*.xib'
  s.frameworks            = 'Foundation', 'UIKit'

  s.dependency 'SimpleOAuth2', '0.0.3'
  s.dependency 'MBProgressHUD', '~> 0.9'
end
