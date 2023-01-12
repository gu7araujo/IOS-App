workspace 'App.xcworkspace'
platform :ios, '15.0'

project 'App.xcodeproj'
target :App_DEV do
  project 'App'
  use_frameworks!
  pod 'SwiftLint'
end

project 'Shared/Shared.xcodeproj'
target :Shared do
  project 'Shared/Shared.xcodeproj'
  use_frameworks!
  target :SharedTests do
  end
end