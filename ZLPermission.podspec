#
# Be sure to run `pod lib lint ZLPermission.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZLPermission'
  s.version          = '0.1.1'
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
     core.weak_framework       = 'AVFoundation'
   end
  s.subspec 'photo' do |core|
     core.source_files = 'ZLPermission/Classes/photo/**/*'
     core.weak_framework       = 'Photos'
   end
  s.subspec 'microphone' do |core|
     core.source_files = 'ZLPermission/Classes/microphone/**/*'
     core.weak_framework       = 'AVFoundation'
   end
  s.subspec 'location' do |core|
     core.source_files = 'ZLPermission/Classes/location/**/*'
     core.weak_framework       = 'CoreLocation'
   end
  s.subspec 'bluetooth' do |core|
     core.source_files = 'ZLPermission/Classes/bluetooth/**/*'
     core.weak_framework       = 'CoreBluetooth'
   end
  s.subspec 'calendar' do |core|
     core.source_files = 'ZLPermission/Classes/calendar/**/*'
     core.weak_framework       = 'EventKit'
   end
  s.subspec 'reminders' do |core|
     core.source_files = 'ZLPermission/Classes/reminders/**/*'
     core.weak_framework       = 'EventKit'
   end
  s.subspec 'tracking' do |core|
     core.source_files = 'ZLPermission/Classes/tracking/**/*'
   end
  s.subspec 'mediaLibrary' do |core|
     core.source_files = 'ZLPermission/Classes/mediaLibrary/**/*'
     core.weak_framework       = 'MediaPlayer'
   end

  s.subspec 'notification' do |core|
     core.source_files = 'ZLPermission/Classes/notification/**/*'
     core.weak_framework       = 'UIKit', 'UserNotifications'
   end
  s.subspec 'health' do |core|
     core.source_files = 'ZLPermission/Classes/health/**/*'
     core.weak_framework       = 'HealthKit'
   end
  s.subspec 'contacts' do |core|
     core.source_files = 'ZLPermission/Classes/contacts/**/*'
     core.weak_framework       = 'Accounts'
   end
  s.subspec 'siri' do |core|
     core.source_files = 'ZLPermission/Classes/siri/**/*'
     core.weak_framework       = 'Intents'
   end
  s.subspec 'speechRecognition' do |core|
     core.source_files = 'ZLPermission/Classes/speechRecognition/**/*'
     core.weak_framework       = 'Speech'
   end
  s.subspec 'motion' do |core|
     core.source_files = 'ZLPermission/Classes/motion/**/*'
     core.weak_framework       = 'CoreMotion'
   end
  
  # s.resource_bundles = {
  #   'ZLPermission' => ['ZLPermission/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
