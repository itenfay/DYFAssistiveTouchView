
Pod::Spec.new do |s|

  s.name         = "DYFAssistiveTouchView"
  s.version      = "4.2.2"
  s.summary      = "实现应用内悬浮按钮和辅助工具条，可以增加/修改功能项，通过事件索引，实现各种场景页面的跳转。"

  s.homepage     = "https://github.com/dgynfi/DYFAssistiveTouchView"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "dyf" => "vinphy.teng@foxmail.com" }
  # s.social_media_url   = "http://twitter.com/dyf"

  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/dgynfi/DYFAssistiveTouchView.git", :tag => s.version.to_s }

  s.source_files  = "Classes/**/*.{h,m}"
  s.public_header_files = "Classes/**/*.h"


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
