//
//  ChatUI.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/7/23.
//

import SwiftUI

struct ChatUI: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var storeVM: StoreVM
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Token.date, ascending: false)])
    private var tokens: FetchedResults<Token>
    @Binding var menuOpen: Bool
    
    var body: some View {
        VStack{
            MenuBar(menuOpen: $menuOpen)
                .environmentObject(modelData)
                .environmentObject(storeVM)
                
                ScrollView {
                    ForEach(modelData.messages, id: \.self){message in
                        TextBubble(chatData: message, is_same_date: true)
                     
                    } .rotationEffect(.degrees(180))
                }.rotationEffect(.degrees(180))
                .padding(.top, 10)
            
            Spacer()
            TextInputView(modelData: modelData)
                .padding(.horizontal, 5)
                .cornerRadius(100)
                .border(.blue)
        }
        
        .onAppear {
         
            getTokensThisMonth()
            
            
            
        }
    }
    func getTokensThisMonth() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let thisMonth = formatter.string(from: Date())
        Database.shared.totalTokens = 0
        var previousMonths = 0
        for token in tokens{
            if let date = token.date {
                let month = formatter.string(from: date)
                
                if month == thisMonth {
                    DispatchQueue.main.async {
                        if token.is_boost {
                            Database.shared.totalTokens -= Int(token.token_count)
                        } else {
                            Database.shared.totalTokens += Int(token.token_count)
                            
                        }
                    }
                    
                    
                } else {
                    //Previous months
                    DispatchQueue.main.async {
                        if token.is_boost {
                            previousMonths -= Int(token.token_count)
                        } else {
                            previousMonths += Int(token.token_count)
                            
                        }
                    }
                    
                }
            }
        }
        DispatchQueue.main.async {
            if previousMonths < 0 {
                Database.shared.totalTokens += previousMonths
            }
        }
        
     
    }
    
}

struct ChatUI_Previews: PreviewProvider {
    static var previews: some View {
        ChatUI(menuOpen: .constant(true))
            .environmentObject(StoreVM())
            .environmentObject(ModelData())
            .environmentObject(Database.shared)
            .environment(\.managedObjectContext, Database.shared.tokenContainer.viewContext)
    }
}
