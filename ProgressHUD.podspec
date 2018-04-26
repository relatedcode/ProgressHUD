Pod::Spec.new do |s|
  s.name         = 'ProgressHUD'
  s.version      = '2.60'
  s.license      = 'MIT'
  s.homepage     = 'http://relatedcode.com'
  s.author       = { 'Related Code' => 'info@relatedcode.com' }
  s.summary      = 'ProgressHUD is a lightweight and easy-to-use HUD for iOS.'
  s.source       = { :git => "https://github.com/relatedcode/ProgressHUD.git", :tag => 'v2.60' }
  s.platform     = :ios
  s.source_files = 'ProgressHUD/ProgressHUD/ProgressHUD.{h,m}'
  s.resources    = 'ProgressHUD/ProgressHUD/ProgressHUD.bundle'
  s.requires_arc = true
  s.ios.deployment_target  = '9.3'
end
