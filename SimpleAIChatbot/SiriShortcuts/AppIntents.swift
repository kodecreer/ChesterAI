//
//  AppIntents.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/8/23.
//

import AppIntents
import SwiftUI

struct AskChesterIntent : AppIntent {
    static var title: LocalizedStringResource = "ask-chester"
    static var openAppWhenRun: Bool = true
    @Parameter(title:LocalizedStringResource("init-phrase"))
    var initial_phrase: String
    
    
    @MainActor
    func perform() async throws -> some IntentResult {
        //Explicitly setting the stuff out of the main thread in model data makes it work....
        AppModel.shared.modelData.messages.append(ChatMessage(is_aibot: false, message: initial_phrase, timestamp: "---"))
        AppModel.shared.modelData.messages.append( ChatMessage(is_aibot: true, message: "...", timestamp: "") )
       AppModel.shared.modelData.fetch_response(isSiri: true)
        var last_message = AppModel.shared.modelData.messages.last?.message ?? "..."
        while last_message == "..."{
            try await Task.sleep(nanoseconds: UInt64(1 * Double(NSEC_PER_SEC)))
            last_message = AppModel.shared.modelData.messages.last?.message ?? "..."
        }
        
        
        return .result(dialog: "chester-response \(AppModel.shared.modelData.messages.last?.message ?? "Message failed")")
        
    }
}

struct AskChesterNoAppIntent : AppIntent {
    static var title: LocalizedStringResource = "ask-chester"
    
    @Parameter(title:LocalizedStringResource("init-phrase"))
    var initial_phrase: String
    
    
    @MainActor
    func perform() async throws -> some IntentResult {

  
        AppModel.shared.modelData.messages.append(ChatMessage(is_aibot: false, message: initial_phrase, timestamp: "---"))
        AppModel.shared.modelData.messages.append( ChatMessage(is_aibot: true, message: "...", timestamp: "") )
       AppModel.shared.modelData.fetch_response(isSiri: true)
        var last_message = AppModel.shared.modelData.messages.last?.message ?? "..."
        while last_message == "..."{
            try await Task.sleep(nanoseconds: UInt64(1 * Double(NSEC_PER_SEC)))
            last_message = AppModel.shared.modelData.messages.last?.message ?? "..."
        }
        

        
        return .result(dialog: "Chesters says: \(AppModel.shared.modelData.messages.last?.message ?? "Message failed")",
                       view: TalkMoreView(answer: "\(AppModel.shared.modelData.messages.last?.message ?? "Message failed")").environmentObject(AppModel.shared.modelData)
        )
    }
}

struct AskChesterShortcut : AppShortcutsProvider{

    static var appShortcuts: [AppShortcut] = [AppShortcut(intent: AskChesterIntent(), phrases: [
        "Start a conversation with ${applicationName}",
        "Chat with ${applicationName}",
        "Comenzar un conversación con ${applicationName}",
        "Charla con ${applicationName}"
        ]), AppShortcut(intent: AskChesterNoAppIntent(), phrases: [
            "Ask ${applicationName}",
            "Quick quesiton ${applicationName}",
            "Pregunta ${applicationName}",
            "Una pregunta ${applicationName}"
        ])]
         
        
    
}



