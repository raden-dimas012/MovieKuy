# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MovieKuy' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MovieKuy
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'SDWebImage'

end

 post_install do |installer|
     installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
            if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12.0
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
            end
         end
     end
  end



