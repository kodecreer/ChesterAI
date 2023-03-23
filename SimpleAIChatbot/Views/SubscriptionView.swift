//
//  SubscriptionView.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/7/23.
//

import SwiftUI

struct SubscriptionView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var storekitManager: StoreVM
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Token.date, ascending: false)])
    private var tokens: FetchedResults<Token>
    var body: some View {
        VStack {
           
            VStack(alignment: .leading){
                Text(storekitManager.purchasedSubscriptions.isEmpty ? LocalKey.premiumNotPayed1 : LocalKey.premiumPayed1)
                    .font(.title)
                Text(LocalKey.premiumFeature1)
                Text(LocalKey.premiumFeature2)
                Text(LocalKey.premiumFeature3)
            }
            .foregroundColor(.white)
            .font(.title2)
            .frame(width: UIScreen.main.bounds.width/1.2)
            .padding()
            .background(.green)
            .cornerRadius(10)
            
            
            HStack {
                if storekitManager.isPremium(){
                    HStack{
                        Button {
                            Task {
                                do {
                                    try await storekitManager.purchase(_:storekitManager.subscriptions
                                        .first(where: {$0.id == "com.temporary.wordbooster"})!)
                                    getTokensThisMonth()
                                }  catch {
                                    print(error)
                                }
                                
                            }
                        } label: {
                            VStack{
                                Text(storekitManager.subscriptions.first(where: {$0.id == "com.temporary.wordbooster"})?.displayName ?? "Couldn't get unit booster")
                                    .foregroundColor(.white)
                                    .font(.title)
                                Image("ChesterLightMode")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Text(storekitManager.subscriptions.first(where: {$0.id == "com.temporary.wordbooster"})?.description ?? "Couldn't get description.")
                                    .foregroundColor(.white)
                                Text(storekitManager.subscriptions.first(where: {$0.id == "com.temporary.wordbooster"})?.displayPrice ?? "Couldn't get price")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                            
                        }
                    .padding()
                    .background(.green)
                    .cornerRadius(20)
                        
                        Text(LocalKey.premiumPayed2)
                            .foregroundColor(.white)
                            .frame(width: 160, height: 160)
                            .padding()
                            .background(.green)
                            .cornerRadius(10)
                        
                        
                    }
                } else {
                    ForEach(storekitManager.subscriptions) {
                        sub in
                        
                            
                            Button {
                                Task {
                                    do {
                                        if let purch = try await storekitManager.purchase(_:sub){
                                            getTokensThisMonth()
                                        }
                                       
                                    } catch {
                                        print(error)
                                    }
                                    
                                }
                            } label: {
                                VStack{
                                    Text(sub.displayName)
                                        .foregroundColor(.white)
                                        .font(.title)
                                    Image(sub.id == "com.temporary.monthly" ? "ChadChesterTransparent": "ChesterLightMode")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        
                                    Text(sub.description)
                                        .foregroundColor(.white)
                                    Text(sub.displayPrice)
                                        .foregroundColor(.white)
                                        .font(.title2)
                                }
                                
                            }
                        .padding()
                        .background(.green)
                        .cornerRadius(20)
                    }
                }
        }
        
            
            
        }
    }
    func getTokensThisMonth() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let thisMonth = formatter.string(from: Date())
        Database.shared.totalTokens = 0
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
                    
                    
                }
            }
        }
     
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView()
            .environmentObject(StoreVM())
            .environment(\.managedObjectContext, Database.shared.tokenContainer.viewContext)
            .environment(\.locale, .init(identifier: "es"))
    }
}
