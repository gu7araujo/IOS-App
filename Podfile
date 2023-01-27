workspace 'App.xcworkspace'
platform :ios, '15.0'

def shared_pods
  pod 'FirebaseCore', '~> 10.4'
  pod 'FirebaseRemoteConfig', '~> 10.4'
  pod 'FirebaseAnalytics', '~> 10.4'
  pod 'FirebaseCrashlytics', '~> 10.4'
  pod 'FirebasePerformance', '~> 10.4'
end

project 'App.xcodeproj'
target :App_DEV do
  project 'App'
  use_frameworks!
  
  shared_pods
  pod 'SwiftLint'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
  end
end

project 'Shared/Shared.xcodeproj'
target :Shared do
  project 'Shared/Shared.xcodeproj'
  use_frameworks!
  shared_pods
  target :SharedTests do
  end
end
