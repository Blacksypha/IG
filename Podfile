# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'IG' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  post_install do |installer|
     installer.pods_project.targets.each do |target|
       target.build_configurations.each do |config|
         config.build_settings['SWIFT_VERSION'] = '3.2'
       end
     end
   end
 end

  # Pods for IG
  pod 'Parse'
  pod 'ParseLiveQuery'
  pod 'ParseUI'

  target 'IGTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'IGUITests' do
    inherit! :search_paths
    # Pods for testing
  end
