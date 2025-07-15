# Uncomment the next line to define a global platform for your project
platform :ios, '17.0'

target 'KOZUKAITYOU' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for KOZUKAITYOU
  pod 'Charts'
  pod 'RealmSwift'
  pod 'TTTAttributedLabel'
  pod 'SVProgressHUD', :git => 'https://github.com/SVProgressHUD/SVProgressHUD.git'
  pod 'EAIntroView' # ここに追加！
  pod 'OCMock'
  pod 'FirebaseUI'
  pod 'Firebase'
  pod 'YMTGetDeviceName'
  pod 'IQKeyboardManager'
  # add the Firebase pod for Google Analytics
  pod 'Firebase/Analytics'
  # add pods for any other desired Firebase products
  # https://firebase.google.com/docs/ios/setup#available-pods
  # pod 'Google-Mobile-Ads-SDK'
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
      end
    end
  end
end
