Pod::Spec.new do |s|
  s.name         = "ProgressHUD"
  s.version      = "2.3"
  s.summary      = "ProgressHUD is a lightweight and easy-to-use HUD for iOS 8."
  s.homepage     = "http://relatedcode.com"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author       = { 'Related Code' => 'info@relatedcode.com' }
  s.source       = { :git => "https://github.com/relatedcode/ProgressHUD.git", :tag => s.version }
  s.platform     = :ios, '8.0'
  s.source_files = '*.{h,m}'
  s.requires_arc = true
end