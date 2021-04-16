platform :ios, '11.0'

use_frameworks!

workspace 'TransformersCardGame'

target 'TransformersCardGame' do
    pod 'Alamofire', '~> 4.1'
    pod 'Moya', '~> 12.0.0'
    pod 'SnapKit', '~> 4.0'
    pod 'Kingfisher', '~> 6.2.1'
    pod 'lottie-ios', '~> 3.2.1'

    target 'TransformersCardGameTests' do
        inherit! :search_paths
        pod 'Cuckoo', '~> 1.4.1'
        pod 'SnapshotTesting', '~> 1.8.1'
        pod 'Quick', '~> 3.1.2'
        pod 'Nimble', '~> 9.0.0'
        pod 'Nimble-Snapshots'
        pod 'OHHTTPStubs/Swift', '~> 9.1.0'
    end

    target 'TransformersCardGameUITests' do
        inherit! :search_paths
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
    end
end
