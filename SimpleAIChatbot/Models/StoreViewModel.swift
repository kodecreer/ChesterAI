//
//  ViewModel.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/7/23.
//

import Foundation
import CoreData
import StoreKit

public enum PurchaseProduct {
    static var moreUnits: String {
        return "com.kdcreer.chesterai.wordbooster"
    }
    static var chesterPlus: String {
        return "com.kdcreer.chesterai.monthly"
    }
}
typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState
class StoreVM : ObservableObject {
    private let productIds: [String] = [ PurchaseProduct.chesterPlus, PurchaseProduct.moreUnits]
    @Published private(set) var subscriptions: [Product]  = []
    @Published private(set) var purchasedSubscriptions: [Product] = []
    @Published private(set) var purchasedIAP: [Product] = []
    @Published private(set) var subscriptionGroupStatus: RenewalState?
    @Published var isPlus = false
    var updateListenerTask : Task<Void, Error>? = nil
    init() {
        
        Task {
            updateListenerTask = listenForTransacitons()
            await requestProducts()
            await updateCustomerProductStatus()
  
        }
        self.isPlus = self.isPremium()
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    func listenForTransacitons() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do{
                    let transaction = try self.checkVerified(result)
                    await self.updateCustomerProductStatus()
                    //Check here to update the thing according to the product sold
                    await transaction.finish()
                    self.isPlus = self.isPremium()
                    if transaction.productID == PurchaseProduct.moreUnits {
                        DispatchQueue.main.async {
                            Database.shared.createTokenLedger(Database.shared.tokenContainer.viewContext, 50000, true)
                            
                        }
                    }
                
                } catch {
                    print(error)
                }
            }
        }
    }
    @MainActor
    func requestProducts() async {
        do {
            subscriptions = try await Product.products(for: productIds)
        } catch {
            print(error)
        }
    }
    
    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        
        switch result {
        case .success(let verificaiton):
            let transaction = try checkVerified(verificaiton)
            await transaction.finish()
            await updateCustomerProductStatus()
            //And right here. We can't allow free credits or my wallet would sink into the ground.
            self.isPlus = self.isPremium()
            if transaction.productID == PurchaseProduct.moreUnits {
                DispatchQueue.main.async {
                    Database.shared.createTokenLedger(Database.shared.tokenContainer.viewContext, 50000, true)
                }
            }
            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerificaiton
        case .verified(let verified):
            return verified
        }
    }
    @MainActor
    func updateCustomerProductStatus() async {
        for await result in Transaction.currentEntitlements {
            do {
                let transcation = try checkVerified(result)
                print(transcation.productType)
                switch transcation.productType {
                case .autoRenewable:
                    if let subscription = subscriptions.first(where: {$0.id == transcation.productID}){
                        purchasedSubscriptions.append(subscription)
                    }
                case .consumable:
                    if let subscription = subscriptions.first(where: {$0.id == transcation.productID}){
                        purchasedIAP.append(subscription)
                    }
                default:
                    print(transcation.productType)
                    break
        
                }
                await transcation.finish()
                //Boom got it done now dog
                print(transcation.productID)
              
                DispatchQueue.main.async {
                    self.isPlus = self.isPremium()
                }
            

            } catch {
                print(error)
            }
        }
    }
    func isPremium() -> Bool{
        return self.purchasedSubscriptions.first(where: {$0.id == "com.temporary.monthly"}) != nil
    }
    
}

public enum StoreError : Error {
    case failedVerificaiton
}
