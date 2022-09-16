# gem install cocoapods-binary
# plugin 'cocoapods-binary'
#
# Step pull new code
#  1. Comment
#       pod 'NetacomSDKs', :git => 'https://github.com/Netacom-NetAlo/NetaloSDKs-iOS', branch: 'vnd/xxxx'
#       pod 'NotificationSDK', :git => 'https://github.com/Netacom-NetAlo/NotiSDKs-iOS', branch: 'vnd/xxx'
#  2. pod install -> remove old code
#  3. pod install -> pull new code
#

platform :ios, '11.0'
use_frameworks!
# keep_source_code_for_prebuilt_frameworks!
inhibit_all_warnings!

# ======================================GROUP PODS==========================================

def gif_pods
  pod 'lottie-ios', '3.2.3'
end

def rx_swift_pods
    pod 'RxSwift', '~> 6.2.0'
    pod 'RxCocoa', '~> 6.2.0'
    pod 'XCoordinator', '~> 2.0'
    pod 'RxGesture', '~> 4.0.2'
    pod 'RxRelay', '~> 6.2.0'
end

def rx_swift_noti_pods
    pod 'RxSwift', '~> 6.2.0'
    pod 'RxCocoa', '~> 6.2.0'
    pod 'RxRelay', '~> 6.2.0'
end

def database_pods
  pod 'RealmSwift', '10.12.0'
end

def language_pods
  pod 'Localize-Swift', :git => 'https://github.com/Netacom-NetAlo/Localize-iOS'
end

def netalo_pods
  pod 'NetacomSDKs', :git => 'https://github.com/Netacom-NetAlo/NetaloSDKs-iOS', branch: 'vnd/sdk_main_v7'
  noti_netalo_pods
end

def noti_netalo_pods
  pod 'NotificationSDK', :git => 'https://github.com/Netacom-NetAlo/NotiSDKs-iOS', branch: 'vnd/sdk_noti_v7'
end

def support_noti_pods
  pod 'ZIPFoundation', '~> 0.9'
  pod 'JitsiMeetSDK', git: 'https://github.com/Netacom-NetAlo/JitsiSDK-iOS.git', branch: 'dev_1.2'
end

def common_pods
  pod 'MessageKit', :git => 'https://github.com/Netacom-NetAlo/Messagekit-iOS'
  pod 'SwiftLinkPreview', :git => 'https://github.com/Netacom-NetAlo/SwiftLinkPreview', branch: 'dev_1.0'
  pod 'Kingfisher', '6.1.1'
  support_noti_pods
end

def tracking_pods
  pod 'Firebase/Analytics', '6.21.0'
  pod 'Firebase/Crashlytics', '6.21.0'
  pod 'FBSDKCoreKit', '8.2.0'
  pod 'AppsFlyerFramework', '5.2.0'
  pod 'Sentry', :git => 'https://github.com/getsentry/sentry-cocoa.git', :tag => "4.3.1"
end

def secret_pods
  pod 'SignalCoreKit', git: 'https://github.com/signalapp/SignalCoreKit.git', :commit => 'eea6884e55261bf157ad6054c72c3c51d7788d4c'
  pod 'AxolotlKit', git: 'https://github.com/signalapp/SignalProtocolKit.git', branch: 'master'
  pod 'HKDFKit', git: 'https://github.com/signalapp/HKDFKit.git'
  pod 'Curve25519Kit', git: 'https://github.com/signalapp/Curve25519Kit'
  pod 'GRKOpenSSLFramework', git: 'https://github.com/signalapp/GRKOpenSSLFramework', branch: 'mkirk/1.0.2t'
end

def socket_pods
  pod 'Socket.IO-Client-Swift', '14.0.0'
end

def testing_pods
#    pod 'Quick', '~> 1.0'
#    pod 'Nimble', '~> 7.0'
end

def resolver
  pod 'Resolver', tag: '1.4.4', git: 'https://github.com/thanhphong-tran/Resolver'
end

def component_pods
  pod 'Carbon', '~> 1.0.0-rc.6'
  pod 'Kingfisher', '6.1.1'
end

# ======================================TARGET PODS==========================================
def app_pods
  gif_pods
  resolver
  rx_swift_pods
  component_pods
  secret_pods
  database_pods
  language_pods
  tracking_pods
  socket_pods
  common_pods
  netalo_pods
end

target 'VNDirectSDKDemo' do
  app_pods
end

# ============================Notification Extension================================
def app_notification_pods
  database_pods
  rx_swift_noti_pods
  resolver
  noti_netalo_pods
  secret_pods
  socket_pods
  language_pods
  support_noti_pods
end

target 'NotificationExtension' do
  app_notification_pods
end

# ============================Share Extension=======================================



# Disable Bitcode because of JitsiMeetSDK
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['ARCHS'] = 'arm64 x86_64'
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
    end
  end
end
