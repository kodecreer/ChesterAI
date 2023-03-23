//
//  SiriPhrases.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/10/23.
//

import Foundation
import AppIntents
public enum SiriPhrases {
    static var conversation: [String]{
        return ["Start a conversation with \(AppShortcutPhraseToken.applicationName)",
                "Hey \(AppShortcutPhraseToken.applicationName) tell me this"]
    
}
}
