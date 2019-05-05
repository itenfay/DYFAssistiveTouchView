
Pod::Spec.new do |s|

  s.name         = "DYFAssistiveTouch"
  s.version      = "4.1.0"
  s.summary      = "DYFAssistiveTouch实现应用内悬浮按钮和辅助工具条，可以动态增加功能项，etc."

  s.homepage     = "https://github.com/Eastze/DYFAssistiveTouch"

  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author       = { "dyf" => "1659640627@qq.com" }
  # s.social_media_url   = "http://twitter.com/dyf"

  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/dgynfi/DYFAssistiveTouch.git", :tag => s.version.to_s }

  s.source_files  = "DYFAssistiveTouchView/**/*.{h,m}"
  s.public_header_files = "DYFAssistiveTouchView/**/*.h"


  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  s.frameworks = "QuartzCore"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
