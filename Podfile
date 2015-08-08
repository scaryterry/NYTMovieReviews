source 'https://github.com/CocoaPods/Specs.git'

# Uncomment this line to define a global platform for your project
platform :ios, '7.0'

target 'Movie Reviews' do
pod 'SDWebImage'
pod 'MBProgressHUD'
pod 'libextobjc'
pod 'VTAcknowledgementsViewController'
pod "AFNetworking", "~> 2.0"
pod 'MagicalRecord'
pod 'DZNEmptyDataSet'
pod 'TSMessages'

end
post_install do | installer |
    require 'fileutils'
    FileUtils.cp_r('Pods/Target Support Files/Pods-Movie Reviews/Pods-Movie Reviews-acknowledgements.plist', 'Pods-acknowledgements.plist', :remove_destination => true)
end