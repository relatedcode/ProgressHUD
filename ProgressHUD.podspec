Pod::Spec.new do |s|
  s.name = 'ProgressHUD'
  s.version = '13.0'
  s.license = 'MIT'

  s.summary = 'A lightweight and easy-to-use Progress HUD for iOS.'
  s.homepage = 'https://relatedcode.com'
  s.author = { 'Related Code' => 'info@relatedcode.com' }

  s.source = { :git => "https://github.com/relatedcode/ProgressHUD.git", :tag => s.version }
  s.source_files = 'ProgressHUD/ProgressHUD/ProgressHUD.swift'

  s.pod_target_xcconfig = {
      "SWIFT_VERSION" => "5.0",
  }
  s.swift_version = '5.0'

  s.ios.deployment_target  = '13.0'

  s.requires_arc = true
  s.platform = :ios
end
