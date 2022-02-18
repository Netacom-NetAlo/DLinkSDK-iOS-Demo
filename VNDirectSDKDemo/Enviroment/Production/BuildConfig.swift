//
//  BuildConfig.swift
//  NetAlo
//
//  Created by Tran Phong on 6/23/21.
//

import NetAloLite
import NetAloFull

struct BuildConfig {
    static var config = NetaloConfiguration(
        enviroment: .production,
        appId: 17,
        appKey: "B2D89AC8B8ECF",
        accountKey: "adminkey",
        appGroupIdentifier: "group.vn.com.vndirect.stockchat",
        storeUrl: URL(string: "https://apps.apple.com/vn/app/vndirect/id1594533471")!,
        analytics: [],
        featureConfig: FeatureConfig(
            user: FeatureConfig.UserConfig(
                forceUpdateProfile: false,
                allowCustomUsername: false,
                allowCustomProfile: false,
                allowCustomAlert: false,
                allowAddContact: false,
                allowBlockContact: false,
                allowSetUserProfileUrl: false,
                allowEnableLocationFeature: true,
                allowTrackingUsingSDK: true,
                isHiddenEditProfile: true,
                allowAddNewContact: false,
                allowEditContact: false
            ),
            chat: FeatureConfig.ChatConfig(
                isVideoCallEnable: true,
                isVoiceCallEnable: true,
                isHiddenSecretChat: true
            ),
            allowReferralCode: false,
            searchByLike: true,
            allowReplaceCountrycode: false
        )
    )
}
