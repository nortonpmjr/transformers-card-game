source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/goinstant/pods-specs-public'

platform :ios, '11.0'

use_frameworks!

workspace 'TransformersCardGame'

target 'TransformersCardGame' do
    pod 'Alamofire'
    pod 'Moya'
    pod 'SnapKit'
    pod 'SwiftLint'


    target 'TransformersCardGameTests' do
        inherit! :search_paths
        pod 'Cuckoo'
        pod 'SnapshotTesting'
        pod 'Quick'
        pod 'Nimble'
        pod 'Nimble-Snapshots'
        pod 'OHHTTPStubs/Swift'
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
        end
    end
end
