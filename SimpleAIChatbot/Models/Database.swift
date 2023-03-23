//
//  MessageDatabase.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/10/23.
//

import Foundation
import CoreData
import CloudKit
import SwiftUI
class Database : ObservableObject {
    static let shared = Database()
    

    @Published var totalTokens: Int = 0
    //let messageContainer: NSPersistentCloudKitContainer
    let tokenContainer: NSPersistentCloudKitContainer
    init() {
        //messageContainer = NSPersistentCloudKitContainer(name: "MessageContain")
        tokenContainer = NSPersistentCloudKitContainer(name: "TokenCounter")
        tokenContainer.loadPersistentStores { storeDesc, error in
            if let error = error as NSError? {
                fatalError("Loading error \(error)")
            }
        }
        tokenContainer.viewContext.automaticallyMergesChangesFromParent = true
        tokenContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
    }
    func createTokenLedger(_ viewContext: NSManagedObjectContext, _ token_count: Int, _ is_boost: Bool) {
        let tokenLedger = Token(context: self.tokenContainer.viewContext)
        tokenLedger.token_count = Int64(token_count)
        tokenLedger.date = Date()
        tokenLedger.is_boost = is_boost
        saveContext(viewContext)
    }
    func saveContext(_ viewContext: NSManagedObjectContext){
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
        
    }
//    func getTokensThisMonth(tokens: [Any]) {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM"
//        let thisMonth = formatter.string(from: Date())
//        Database.shared.totalTokens = 0
//        var toks = tokens as! FetchedResults<Task>
//        for token in toks{
//            if let date = token.date {
//                let month = formatter.string(from: date)
//                
//                if month == thisMonth {
//                    DispatchQueue.main.async {
//                        if token.is_boost {
//                            Database.shared.totalTokens -= Int(token.token_count)
//                        } else {
//                            Database.shared.totalTokens += Int(token.token_count)
//                            
//                        }
//                    }
//                    
//                    
//                }
//            }
//        }
//     
//    }
    
    
    //TODO: After release create a clean up function so over time it doesn't turn into a ticking time
    //TODO: for storage space
    
}
