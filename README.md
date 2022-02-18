# Coding conventions
https://google.github.io/swift/

# VNDNativeDemo
Netalo demo app
Xcode: 13.2.1
Swift 5

1.Open Podfile -> In "def netalo_pods" pls select options on device or simulator

2.Pod install

3.Open Appdelegate.swift -> In "func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:" 

  - Init NetaloSDK at here 
  - Select the setUser() funtions which you want for testing. In your app, this function will called ASAP when client logined successfully. Note: "Only select 1 or 2 to test and remove the app if you want to switch setUser()"
  Ex: call setUser1() and close the setUser2()

4. Run to testing 
