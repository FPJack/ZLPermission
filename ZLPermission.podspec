#
# Be sure to run `pod lib lint ZLPermission.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZLPermission'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ZLPermission.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/FPJack/ZLPermission.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fanpeng' => 'peng.fan@ukelink.com' }
  s.source           = { :git => 'https://github.com/FPJack/ZLPermission.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.resource_bundles = {'ZLPermission_Rrivacy' => ['ZLPermission/Resources/PrivacyInfo.xcprivacy']}

#  s.source_files = 'ZLPermission/Classes/**/*'
  s.subspec 'base' do |core|
     core.source_files = 'ZLPermission/Classes/base/**/*'
   end
  s.subspec 'camera' do |core|
     core.source_files = 'ZLPermission/Classes/camera/**/*'
   end
  s.subspec 'photo' do |core|
     core.source_files = 'ZLPermission/Classes/photo/**/*'
   end
  s.subspec 'microphone' do |core|
     core.source_files = 'ZLPermission/Classes/microphone/**/*'
   end
  s.subspec 'location' do |core|
     core.source_files = 'ZLPermission/Classes/location/**/*'
   end
  s.subspec 'bluetooth' do |core|
     core.source_files = 'ZLPermission/Classes/bluetooth/**/*'
   end
  s.subspec 'calendar' do |core|
     core.source_files = 'ZLPermission/Classes/calendar/**/*'
   end
  s.subspec 'reminders' do |core|
     core.source_files = 'ZLPermission/Classes/reminders/**/*'
   end
  s.subspec 'tracking' do |core|
     core.source_files = 'ZLPermission/Classes/tracking/**/*'
   end
  s.subspec 'mediaLibrary' do |core|
     core.source_files = 'ZLPermission/Classes/mediaLibrary/**/*'
   end
  s.subspec 'network' do |core|
     core.source_files = 'ZLPermission/Classes/network/**/*'
   end
  s.subspec 'notification' do |core|
     core.source_files = 'ZLPermission/Classes/notification/**/*'
   end
  s.subspec 'health' do |core|
     core.source_files = 'ZLPermission/Classes/health/**/*'
   end
  s.subspec 'contacts' do |core|
     core.source_files = 'ZLPermission/Classes/contacts/**/*'
   end
  s.subspec 'siri' do |core|
     core.source_files = 'ZLPermission/Classes/siri/**/*'
   end
  s.subspec 'speechRecognition' do |core|
     core.source_files = 'ZLPermission/Classes/speechRecognition/**/*'
   end
  
  # s.resource_bundles = {
  #   'ZLPermission' => ['ZLPermission/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
