//
//  SimpleAIChatbotApp.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 1/31/23.
//

import SwiftUI

@main
struct SimpleAIChatbotApp: App {
    
    @StateObject var modelData: ModelData = AppModel.shared.modelData
    @StateObject var storeManager: StoreVM = AppModel.shared.storeManager
    let database: Database = Database.shared
    var body: some Scene {
        
        WindowGroup {
            NavigationStack{
                ContentView()
                    .environmentObject(modelData)
                    .environmentObject(storeManager)
                    .environment(\.managedObjectContext, database.tokenContainer.viewContext)
                    
                
            }
         
            
        }
    }
}
