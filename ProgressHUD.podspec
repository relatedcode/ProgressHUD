Pod::Spec.new do |s|
  s.name         = 'ProgressHUD'
  s.version      = '2.3'
  s.license      = 'MIT'
  s.homepage     = 'http://relatedcode.com'
  s.author       = { 'Related Code' => 'info@relatedcode.com' }
  s.summary      = 'ProgressHUD is a lightweight and easy-to-use HUD for iOS 8.'
  s.source       = { :git => "https://github.com/relatedcode/ProgressHUD.git", :tag => 'v2.3' }
  s.platform     = :ios, '8.0'
  s.source_files = 'ProgressHUD/ProgressHUD/*'
  s.requires_arc = true
end