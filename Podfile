workspace 'App.xcworkspace'
platform :ios, '13.0'

def shared_msal_pod
  pod 'MSAL'
end

project 'App.xcodeproj'
target :App do
  project 'App'
  use_frameworks!

  shared_msal_pod
  pod 'SwiftLint'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
        config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
      end
    end
  end
end


project 'Shared/Shared.xcodeproj'
target :Shared do
  project 'Shared/Shared.xcodeproj'
  use_frameworks!

  target :SharedTests do
  end
end

project 'Profile/Profile.xcodeproj'
target :Profile do
  project 'Profile/Profile.xcodeproj'
  use_frameworks!

  shared_msal_pod

  target :ProfileTests do
  end
end
