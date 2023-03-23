//
//  AppModel.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/8/23.
//

import Foundation
import CloudKit
class AppModel : ObservableObject {
    static let shared = AppModel()
    let modelData = ModelData()
    let storeManager = StoreVM()
}
