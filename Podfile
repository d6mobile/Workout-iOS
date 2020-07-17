# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Workout' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Workout
  pod "Alamofire"
  pod "KeychainAccess"
  pod 'NVActivityIndicatorView', :git => 'https://github.com/ninjaprox/NVActivityIndicatorView.git', :tag => '4.8.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # Current pod MessageKit does not update to support version of swift
      config.build_settings['SWIFT_VERSION'] = '5.0'
    end
  end
  # Fix build long time
  installer.pods_project.build_configurations.each do |config|
    if config.name == 'Release' || config.name == 'Release-Dev' || config.name == 'Release-Staging' || config.name == 'Debug-Local'
      config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
      config.build_settings['SWIFT_COMPILATION_MODE'] = 'singlefile'
    else
      config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-O'
      config.build_settings['SWIFT_COMPILATION_MODE'] = 'singlefile'
    end
  end
end

