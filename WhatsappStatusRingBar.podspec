#
# Be sure to run `pod lib lint WhatsappStatusRingBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WhatsappStatusRingBar'
  s.version          = '0.1.0'
  s.summary          = 'Whatsapp Status Ring Bar for your iOS apps.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
WhatsappStatusRingBar is a circular progress bar for iOS written in Swift, easy to customizd via Interface builder or by code.
                       DESC

  s.homepage         = 'https://github.com/divyeshpansuriya-ios/WhatsappStatusRingBar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'divyeshpansuriya-ios' => 'adpansuriya7300@gmail.com' }
  s.source           = { :git => 'https://github.com/divyeshpansuriya-ios/WhatsappStatusRingBar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.source_files = 'WhatsappStatusRingBar/Classes/**/*'
  s.ios.source_files = 'WhatsappStatusRingBar/Classes/**/*'
  # s.resource_bundles = {
  #   'WhatsappStatusRingBar' => ['WhatsappStatusRingBar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'Foundation', 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
