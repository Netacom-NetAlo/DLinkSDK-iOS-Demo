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
//import NATheme
import RxCocoa
import RxSwift
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    // MARK: Stored properties

    private lazy var mainWindow = UIWindow(frame: UIScreen.main.bounds)

    public var netAloFull: NetAloFull!

    private var disposeBag = DisposeBag()
    
    // MARK: - Application Delegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.netAloFull = NetAloFull(
            config: BuildConfig.config
        )
        
        // Only show SDK after start success, Waiting maximun 10s
        self.netAloFull
            .start()
            .timeout(.seconds(10), scheduler: MainScheduler.instance)
            .catchAndReturn(())
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .do(onNext: { (owner, _) in
                // Init rooter

                let mainTabBarController = DemoMainTabbarVC()
                mainTabBarController.initialize(sdk: owner.netAloFull)
                
                owner.netAloFull.buildSDKModule()
                owner.mainWindow.rootViewController  = mainTabBarController
                owner.mainWindow.makeKeyAndVisible()
                //TODO -Make sure client must login successed to set user info here
                
                owner.setUser()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        // Optional use notification
        self.netAloFull.requestNotificationtPermission()
        UNUserNotificationCenter.current().delegate = self
        
        return netAloFull.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    public func setUser() {
            let user = NetAloUserHolder(id: 4785074604085462,
                                        phoneNumber: "maihuong1497",
                                        email: "",
                                        fullName: "Nguyễn Mai Hương",
                                        avatarUrl: "",
                                        session: "7c922a7b662184b39ae47ca486c14cf028f371ce")
            do {
                try self.netAloFull.set(user: user)
            } catch let e {
                print("Error \(e)")
            }


            bindingService()
        }
    
    // MARK: - AppDelegateViewModelOutputs
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        netAloFull.applicationDidBecomeActive(application)
    }

    public func applicationWillResignActive(_ application: UIApplication) {
        netAloFull.applicationWillResignActive(application)
    }

    public func applicationWillTerminate(_ application: UIApplication) {
        netAloFull.applicationWillTerminate(application)
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        netAloFull.application(application, supportedInterfaceOrientationsFor: window)
    }

    // UserActivity
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        netAloFull.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }

    // Notification methods
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        netAloFull.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        netAloFull.application(application, open: url, sourceApplication: sourceApplication, annotation: application)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        netAloFull.application(app, open: url, options: options)
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        netAloFull.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
    }

    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        netAloFull.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
}

//MARK: SDK call back
extension AppDelegate {
    //SDK binding service
    private func bindingService() {
        self.netAloFull.eventObservable
            .asDriverOnErrorJustSkip()
            .drive(onNext: { [weak self] event in
                guard let self = self else { return }
                dump("Event 🤟🏻🤟🏻🤟🏻🤟🏻🤟🏻🤟🏻 \(event)")
                switch event {
                case .pressedUrl(let url):
                    dump("PressedUrl 💪💪💪 : \(url)")
                case .mediaURL(let imageUrls, let videoUrls):
                    dump("Images 💪💪💪: \(imageUrls)")
                    dump("Video 💪💪💪: \(videoUrls)")
                case .checkUserIsFriend(let userId):
                    dump("Check Chat with 💪💪💪 : \(userId)")
                case .didCloseSDK:
                    dump("didCloseSDK 💪💪💪")
                case .pressedCall(let type):
                    dump("pressedCall 💪💪💪 type \(type)")
                case .sessionExpired:
                    dump("sessionExpired 💪💪💪")
                case .updateBadge(let badge) :
                    dump("updateBadge 💪💪💪 \(badge)")
                default: break
                }
            })
            .disposed(by: disposeBag)
    }
}
