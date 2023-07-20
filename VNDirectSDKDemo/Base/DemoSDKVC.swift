//
//  DemoSDKVC.swift
//  VNDirectSDKDemo
//
//  Created by Hieu Bui Van  on 17/02/2022.
//

import Foundation
import UIKit
import RxSwift
import NADomain
import NetAloFull
import NATheme
import Resolver

class DemoSDKVC: UIViewController {
    @LazyInjected public var themeManager: NAThemeServiceProtocol
    
    private let buttonSetUserAfterLogout: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set User After Logout", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let buttonChangeThemePurple: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change Theme Purple", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let buttonChangeThemeOrange: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change Theme Orange", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let buttonShowChat: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("show chat", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let buttonShowVN: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Vietnamese", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let buttonShowEN: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("English", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let buttonShowGroupChat: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("show group chat", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let buttonShowListGroup: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("show list group", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let buttonShowCall: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("personal call", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    private let buttonDidReceive: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("DidReceive Message", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    private let buttonCheckToken: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Check Token", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    private let buttonShowNumberOfBadge: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Badge Number", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let buttonLogout: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    private let stackview: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()
    
    private var netaloSDK: NetAloFullManager?
    
    init(netaloSDK: NetAloFullManager?) {
        self.netaloSDK = netaloSDK
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initSubview()
        
    }
    
    private func initSubview() {
        view.addSubview(stackview)
        
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackview.topAnchor.constraint(equalTo: view.topAnchor),
            stackview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
        
        stackview.addArrangedSubview(buttonShowVN)
//        stackview.addArrangedSubview(buttonShowEN)
        stackview.addArrangedSubview(buttonShowChat)
        stackview.addArrangedSubview(buttonShowGroupChat)
        stackview.addArrangedSubview(buttonShowListGroup)
        stackview.addArrangedSubview(buttonShowCall)
        stackview.addArrangedSubview(buttonDidReceive)
        stackview.addArrangedSubview(buttonShowNumberOfBadge)
        stackview.addArrangedSubview(buttonCheckToken)
        stackview.addArrangedSubview(buttonChangeThemePurple)
        stackview.addArrangedSubview(buttonChangeThemeOrange)
        stackview.addArrangedSubview(buttonSetUserAfterLogout)
        stackview.addArrangedSubview(buttonLogout)
        
        buttonShowVN.addTarget(self, action: #selector(ActionShowVN), for: .touchUpInside)
//        buttonShowEN.addTarget(self, action: #selector(ActionShowEN), for: .touchUpInside)
        buttonShowChat.addTarget(self, action: #selector(ActionShowChat), for: .touchUpInside)
        buttonShowListGroup.addTarget(self, action: #selector(ActionShowListGroup), for: .touchUpInside)
        buttonShowGroupChat.addTarget(self, action: #selector(ActionShowGroupChat), for: .touchUpInside)
        buttonShowCall.addTarget(self, action: #selector(ActionShowCall), for: .touchUpInside)
        buttonChangeThemePurple.addTarget(self, action: #selector(ActionChangeThemePurple), for: .touchUpInside)
        buttonChangeThemeOrange.addTarget(self, action: #selector(ActionChangeThemeOrange), for: .touchUpInside)
        buttonSetUserAfterLogout.addTarget(self, action: #selector(ActionSetUserAfterLogout), for: .touchUpInside)
        buttonShowNumberOfBadge.addTarget(self, action: #selector(NumberOfBadge), for: .touchUpInside)
        buttonDidReceive.addTarget(self, action: #selector(ActionDidReceive), for: .touchUpInside)
        buttonLogout.addTarget(self, action: #selector(ActionLogout), for: .touchUpInside)
        buttonCheckToken.addTarget(self, action: #selector(ActionCheckToken), for: .touchUpInside)

    }
    
    public func showBadge(with number: Int) {
        self.buttonShowListGroup.setTitle( number != 0 ? "show list group ♥️" : "show list group", for: .normal)
    }
    
    @objc func ActionShowEN() {
        self.netaloSDK?.setLanguage(with: .english)
    }
    
    @objc func ActionShowVN() {
        self.netaloSDK?.setLanguage(with: .vietnamese)
    }
    
    @objc func ActionShowChat() {
        let testContact = NAContact(id: 4785074606744072, phone: "rooney", fullName: "rooney", profileUrl: "")
        self.netaloSDK?.showChat(with: testContact, completion: { error in
            let err = error as? NAError
            print("showChat with err: \(err?.description ?? "")")
        })
    }

    @objc func ActionDidReceive() {
        self.netaloSDK?.didReceive(
            messageJson: "{\"messageId\":\"637844810459254798\",\"groupId\":\"4794535825664490\",\"message\":\"1234a98\",\"senderUin\":\"4785074617643083\",\"createdAt\":\"1686906959572377\",\"recipientUins\":[\"4785074617681017\",\"4785074617709101\"],\"type\":\"text\",\"attachments\":\"\",\"groupType\":\"GROUP_TYPE_PUBLIC\",\"nonce\":\"n637844810459254798\"}",
            completion: { error in
                let err = error as? NAError
                print("didReceive with err: \(err?.description ?? "")")
            }
        )
    }

    @objc func NumberOfBadge() {
        self.netaloSDK?.getNumberOfBadge({ NumberOfBadge in
            print("NumberOfBadge: \(NumberOfBadge)")
        })

    }
    
    @objc func ActionShowGroupChat() {
        self.netaloSDK?.showGroupChat(with: "4793279953864738", completion: { error in
            let err = error as? NAError
            print("showGroupChat with err: \(err?.description ?? "")")
        })
    }
    
    @objc func ActionShowListGroup() {
        self.netaloSDK?.showListGroup(completion: { error in
            let err = error as? NAError
            print("showVNDemoVC with err: \(err?.description ?? "")")
        })
    }
    
    @objc func ActionShowCall() {
        let testContact = NAContact(id: 4785074606744072, phone: "rooney", fullName: "rooney", profileUrl: "")
        self.netaloSDK?.showCall(with: testContact, isVideoCall: false, completion: { error in
            let err = error as? NAError
            print("showCall with err: \(err?.description ?? "")")
        })
    }
    
//    @objc func ActionSendMessage() {
//        self.netaloSDK?.sendMessage(content: "SDK TEST SEND MESSAGE", targetUserID: "281474977725116", completion: { _status in
//            print("SDK TEST SEND STATUS: \(_status)")
//        })
//    }
    
    @objc func ActionChangeThemePurple() {
        themeManager.setPrimaryColor(.purple)
    }
    
    @objc func ActionChangeThemeOrange() {
        themeManager.setPrimaryColor(.orange)
    }
    
    @objc func ActionSetUserAfterLogout() {
        let user = NetAloUserHolder(id: 4785074617633555,
                                    phoneNumber: "maymaylam24",
                                    email: "",
                                    fullName: "NGUYỄN LÂM HỒNG MINH",
                                    avatarUrl: "",
                                    session: "0120a6ed20327d154bdc9521c1db8992dc1fV2x2")
        do {
            try self.netaloSDK?.set(user: user)
        } catch let e {
            print("Error \(e)")
        }
    }

    @objc func ActionCheckToken() {
        self.netaloSDK?.checkTokenAvailable("0686c590d5d9c7d34fc2ad8b2f39382a711aBmsD",
            completion: { isAvailable in
                print("checkTokenAvailable: \(isAvailable ? "true" : "flase")")
            }
        )
    }
    
    @objc func ActionLogout() {
        netaloSDK?.logout()
    }
}

