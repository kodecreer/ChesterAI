//
//  InternetMessageModel.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/4/23.
//

import Foundation
/*
 {

       "content": "My name is Cheskco.",
 is_bot: false

 }
 */
struct MessageModel: Codable {
    var tokens: Int
    var content: String
    var is_bot: Bool
    
}
