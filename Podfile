platform :ios, '17.0'

target 'KOZUKAITYOU' do
  use_frameworks!

  # Pods for KOZUKAITYOU

  # Charts for data visualization
  pod 'DGCharts'

  # Local database
  pod 'RealmSwift'

  # Keyboard management
  pod 'IQKeyboardManager', '~> 8.0'

  # Firebase services
  pod 'Firebase'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
      end
    end
  end

  # Xcode 15対応 - DT_TOOLCHAIN_DIR エラー修正
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      xcconfig_path = config.base_configuration_reference&.real_path
      if xcconfig_path && File.exist?(xcconfig_path)
        xcconfig = File.read(xcconfig_path)
        xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
        File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
      end
    end
  end
end
