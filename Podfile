# platform :ios, '9.0'

workspace 'FoodDelivery.xcworkspace'

use_frameworks!

inhibit_all_warnings!

def framework_pods
    pod 'RxSwift', '~> 5.1'
    pod 'RxCocoa', '~> 5.1'
    pod 'Moya', '~> 14.0'
    pod 'ObjectMapper', '~> 3.5'
end

target 'FoodDeliveryApp' do
    project 'FoodDeliveryApp/FoodDeliveryApp.xcodeproj'
    framework_pods
end

target 'FoodDeliveryAppTests' do
    project 'FoodDeliveryApp/FoodDeliveryApp.xcodeproj'
end
