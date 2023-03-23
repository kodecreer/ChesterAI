//
//  Localkey.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/8/23.
//

import SwiftUI

public enum LocalKey {
    static var premium: LocalizedStringKey {
        return "menu-tab-premium"
    }
    static var owner: LocalizedStringKey {
        return "settings-owner"
    }
    static var contact: LocalizedStringKey {
        return "settings-contact"
    }
    static var about: LocalizedStringKey {
        return "settings-about"
    }
    static var tos: LocalizedStringKey{
        return "settings-tos"
    }
    static var privacy: LocalizedStringKey {
        return "settings-privacy"
    }
    static var restore: LocalizedStringKey {
        return "settings-restore"
    }
    static var chatTitle: LocalizedStringKey {
        return "menu-chat-title"
    }
    //Below must be manually inserted for string interpolation
//    static var chatUnits: String { //for string interpolation
//        return "menu-chat-units %@ %@"
//    }
    static var chatPrompt: LocalizedStringKey {
        return "chat-prompt"
    }
    static var chatClipboard: LocalizedStringKey {
        return "chat-clipboard"
    }
    static var chatError: LocalizedStringKey {
        return "chat-error-internet-down"
    }
    static var menuRate: LocalizedStringKey {
        return "menu-tab-rate-us"
    }
    static var menuHelp: LocalizedStringKey {
        return "menu-tab-help"
    }
    static var menuShare: LocalizedStringKey {
        return "menu-tab-share"
    }
    static var menuSettings: LocalizedStringKey {
        return "menu-tab-settings"
    }
    
    
    static var premiumNotPayed1: LocalizedStringKey {
        return "premium-np1"
    }
    static var premiumPayed1: LocalizedStringKey {
        return "premium-p1"
    }
    static var premiumPayed2: LocalizedStringKey {
        return "premium-p2"
    }
    static var premiumFeature1: LocalizedStringKey {
        return "premium-f1"
    }
    static var premiumFeature2: LocalizedStringKey {
        return "premium-f2"
    }
    static var premiumFeature3: LocalizedStringKey {
        return "premium-f3"
    }
    static var siriUnits: LocalizedStringKey{
        return "siri-units"
    }
    static var intro: LocalizedStringKey {
        return "intro"
    }
    static var introAPP: LocalizedStringKey {
        return "intro-a-pp"
    }

    static var introAVP: LocalizedStringKey {
        return "intro-v-pp"
    }

    static var introATOS: LocalizedStringKey {
        return "intro-a-tos"
    }

    static var introVTOS: LocalizedStringKey {
        return "intro-v-tos"
    }

    static var introContinue: LocalizedStringKey {
        return "intro-continue"
    }

    static var errorDesc: LocalizedStringKey {
        return "errror-desc"
    }
    static var helpIntro: LocalizedStringKey {
        return "help-intro"
    }
    static var helpTitle1: LocalizedStringKey {
        return "help-commands-title1"
    }

    static var helpTitle2: LocalizedStringKey {
        return "help-commands-title2"
    }

    static var helpTitle3: LocalizedStringKey {
        return "help-commands-title3"
    }
 
}
