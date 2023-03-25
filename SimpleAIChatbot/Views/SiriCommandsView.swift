//
//  SiriCommandsView.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/10/23.
//

import SwiftUI
import AppIntents

struct CommandModel: Identifiable {
    let id: UUID = UUID()
    let text: LocalizedStringKey
}

struct SiriCommandsView: View {
    var chatStarts: [CommandModel] = [
        CommandModel(text: "siri-chat-phrase-1 \("Chester AI")")
        ,
        CommandModel(text: "siri-chat-phrase-2 \("Chester")")
        
        
    
    ]
    var chatQuick: [CommandModel] = [
        CommandModel(text: "siri-quick-phrase-1 \("Chester AI")")
        ,
        CommandModel(text: "siri-quick-phrase-2 \("Chester AI")")
        ,
    ]
    var body: some View {
        
      
        VStack{
            Text(LocalKey.helpTitle1)
                .font(.title)
                .alignmentGuide(.leading) { context in
                    context[.leading]
                }
                .padding()
                .padding(.top)
            VStack(alignment: .center){
                ForEach(chatStarts) {
                    command in
                    Text(command.text)
                        .font(.system(size: 20))
                        .textSelection(.enabled)
                }
            }
            Text(LocalKey.helpTitle2)
                .font(.title)
                .alignmentGuide(.leading) { context in
                    context[.leading]
                }
                .padding()
            VStack(alignment: .center){
                ForEach(chatQuick) {
                    command in
                    Text(command.text)
                        .font(.system(size: 20))
                        .textSelection(.enabled)
                }
            }
            ScrollView {
                Text(LocalKey.helpTitle3)
                    .padding()
                    .font(.title)
                Text(LocalKey.helpIntro)
                    .padding()
            }
            
            Spacer()
        }
    }
}

struct SiriCommandsView_Previews: PreviewProvider {
    static var previews: some View {
        SiriCommandsView()
            .environment(\.locale, .init(identifier: "es"))
    }
}
