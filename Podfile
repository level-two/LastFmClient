# Uncomment the next line to define a global platform for your project
 platform :ios, '11.0'

target 'LastFmClient' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LastFmClient
  pod 'PromiseKit'
  pod 'RealmSwift'
  pod 'SwiftLint'

  target 'LastFmClientTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'LastFmClientUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.2'
    end
  end
end
