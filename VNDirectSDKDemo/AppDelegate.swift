//
//  AppDelegate.swift
//  VNDirectSDKDemo
//
//  Created by Hieu Bui Van  on 17/02/2022.
//

import UIKit
import NACoreUI
import NetAloFull
import NetAloLite
import XCoordinator
import NALocalization
import RxCocoa
import RxSwift
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    // MARK: Stored properties

    private lazy var mainWindow = UIWindow(frame: UIScreen.main.bounds)

    public var netAloSDK: NetAloFullManager!

    private var disposeBag = DisposeBag()
    
    // MARK: - Application Delegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.netAloSDK = NetAloFullManager(
            config: BuildConfig.config
        )
        
        // Only show SDK after start success, Waiting maximun 10s
        self.netAloSDK
            .start()
            .timeout(.seconds(10), scheduler: MainScheduler.instance)
            .catchAndReturn(())
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .do(onNext: { (owner, _) in
                // Init rooter

                let mainTabBarController = DemoMainTabbarVC()
                mainTabBarController.initialize(sdk: owner.netAloSDK)
                
                owner.netAloSDK.buildSDKModule()
                owner.mainWindow.rootViewController  = mainTabBarController
                owner.mainWindow.makeKeyAndVisible()
                //TODO -Make sure client must login successed to set user info here
                
                owner.setUser()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        // Optional use notification
        self.netAloSDK.requestNotificationtPermission()
        UNUserNotificationCenter.current().delegate = self
        
        return netAloSDK.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    public func setUser() {
        let user = NetAloUserHolder(id: 4785074606697392,
                                    phoneNumber: "son1990",
                                    email: "",
                                    fullName: "son1990",
                                    avatarUrl: "",
                                    session: "b2d7e47a62b5cb14f698dc210d8958bfef984816")
        do {
            try self.netAloSDK?.set(user: user)
        } catch let e {
            print("Error \(e)")
        }
        
        
        bindingService()
    }
    
    // MARK: - AppDelegateViewModelOutputs
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        netAloSDK.applicationDidBecomeActive(application)
    }

    public func applicationWillResignActive(_ application: UIApplication) {
        netAloSDK.applicationWillResignActive(application)
    }

    public func applicationWillTerminate(_ application: UIApplication) {
        netAloSDK.applicationWillTerminate(application)
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        netAloSDK.application(application, supportedInterfaceOrientationsFor: window)
    }

    // UserActivity
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        netAloSDK.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }

    // Notification methods
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        netAloSDK.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        netAloSDK.application(application, open: url, sourceApplication: sourceApplication, annotation: application)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        netAloSDK.application(app, open: url, options: options)
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        netAloSDK.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
    }

    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        netAloSDK.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
}

//MARK: SDK call back
extension AppDelegate {
    //SDK binding service
    private func bindingService() {
        self.netAloSDK.eventObservable
            .asDriverOnErrorJustSkip()
            .drive(onNext: { [weak self] event in
                dump("Event: \(event)")
                switch event {
                case .pressedUrl(let url):
                    dump("PressedUrl: \(url)")
                case .mediaURL(let imageUrls, let videoUrls):
                    dump("Images: \(imageUrls)")
                    dump("Video: \(videoUrls)")
                case .checkUserIsFriend(let userId):
                    dump("Check Chat with: \(userId)")
                case .didCloseSDK:
                    dump("didCloseSDK")
                case .pressedCall(let type):
                    dump("pressedCall type: \(type)")
                case .sessionExpired:
                    dump("sessionExpired")
                case .updateBadge(let badge) :
                    dump("updateBadge: \(badge)")
                case .tokenAvailable(let isAvailable):
                    dump("tokenAvailable \(isAvailable)")
                default: break
                }
            })
            .disposed(by: disposeBag)
    }
}
