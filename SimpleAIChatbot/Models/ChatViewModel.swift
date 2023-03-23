//
//  ChatModel.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 2/8/23.
//

import Foundation

struct ChatMessage : Identifiable, Hashable {
    let id = UUID()
    let is_aibot: Bool
    let message: String
    let timestamp: String
    
}



func datetime_to_string(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd-yyyy"
    return formatter.string(from: date)
}
func string_to_datetime(_ date: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd-yyyy"
    guard let finalDate = formatter.date(from: date) else {return nil}
    return finalDate
}


