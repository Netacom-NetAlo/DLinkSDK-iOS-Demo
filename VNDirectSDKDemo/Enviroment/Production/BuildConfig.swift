//
//  BuildConfig.swift
//  NetAlo
//
//  Created by Tran Phong on 6/23/21.
//

import NetAloLite
import NetAloFull
import CloudKit

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
                allowEnableLocationFeature: false,
                allowTrackingUsingSDK: true,
                allowTrackingBadgeNumber: true,
                isHiddenEditProfile: true,
                allowAddNewContact: false
            ),
            chat: FeatureConfig.ChatConfig(
                isVideoCallEnable: true,
                isVoiceCallEnable: true,
                isHiddenSecretChat: true
            ),
            isSyncDataInApp: true,
            allowReferralCode: false,
            searchByLike: true,
            allowReplaceCountrycode: false,
            isSyncContactInApp: true
        ),
        permissions: [SDKPermissionSet.microPhone]
    )
}
