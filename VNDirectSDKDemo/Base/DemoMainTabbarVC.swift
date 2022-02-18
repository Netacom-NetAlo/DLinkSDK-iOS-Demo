//
//  DemoMainTabbarVC.swift
//  VNDirectSDKDemo
//
//  Created by Hieu Bui Van  on 17/02/2022.
//

import UIKit
import NetAloFull

class DemoMainTabbarVC: UITabBarController, UITabBarControllerDelegate {
    
    private var sdk: NetAloFull?
    
    func initialize(sdk: NetAloFull) {
        self.sdk = sdk
        super.loadView()
        
        let communityTabBarItem = UITabBarItem()
        communityTabBarItem.title = "Contact"
        communityTabBarItem.image = Assets.tabBarContactIcon
        
        let groupTabBarItem = UITabBarItem()
        groupTabBarItem.title = "Call"
        groupTabBarItem.image = Assets.tabBarCallIcon
        
        let messageTabBarItem = UITabBarItem()
        messageTabBarItem.title = "Messager"
        messageTabBarItem.image = Assets.tabBarMessageIcon
        
        let accountTabBarItem = UITabBarItem()
        accountTabBarItem.title = "Demo"
        accountTabBarItem.image = Assets.tabBarAccountIcon
        accountTabBarItem.tag = 4
    
        
        let communityVC = UIViewController()
        
        let groupVC = UIViewController()
        let messageVC = DemoSDKVC(netaloSDK: sdk)
        let accountVC = UIViewController()
        
        communityVC.tabBarItem = communityTabBarItem
        groupVC.tabBarItem = groupTabBarItem
        messageVC.tabBarItem = messageTabBarItem
        
        accountVC.tabBarItem = accountTabBarItem
        
        // setup maintabbar
        viewControllers = [communityVC, groupVC, messageVC, accountVC]
        selectedViewController = communityVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

            // Check if bar item selected is center
            if viewController.tabBarItem.tag == 4 {


                // Do Something Here ...


                // Present View Controller
                sdk?.showVNDemoVC()
                // Returning false will not open the connected tab bar item view controller you attached to it
                return false

            }

            // Return true to open the connected tab bar item view controller you attached to it (e.x. everything but the center item)
            return true
        }

    
    // load data in tree folder
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}


struct Assets {
    static var tabBarMessageIcon = UIImage(named: "tabBar_message_icon")
    static var tabBarCallIcon    = UIImage(named: "tabBar_call_icon")
    static var tabBarContactIcon = UIImage(named: "tabBar_contact_icon")
    static var tabBarAccountIcon = UIImage(named: "tabBar_account_icon")
}
