//
//  ModelData.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/4/23.
//

import Foundation
import SwiftUI
import StoreKit
import CloudKit


struct ChatBit: Codable {
    let role: String
    let content: String
}

struct ChatRequest: Codable {
    let messages: [ChatBit]
    let tokens: Int
    let limit: Int
}

class ModelData: ObservableObject {
 
    @Published var messages: [ChatMessage] = []
    @Published var isChat: Bool = true
    let url: URL = URL(string: "https://chester.api.kdcreer.com/send_message")!
    
    
    
    
    func fetch_response(isSiri: Bool=false){
        self.isChat = false
        let error_message = ChatMessage(is_aibot: true, message: Locale.current.language.languageCode?.identifier ?? "en" == "en" ? "An error has occured. Please connect to the internet in order for the service to work properly" : "Un error ha occurido. Por favor connectar al red asi el servicio funciona correctamente.", timestamp: "")
        withAnimation {
            if !isSiri {
                DispatchQueue.main.async {
                    self.messages.append( ChatMessage(is_aibot: true, message: "...", timestamp: "") )
                }
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                var request = URLRequest(url: self.url)
                request.httpMethod = "POST"
                
                var body: [ChatBit] = []
                for message in self.messages {
                    let role = message.is_aibot ? "assistant" : "user"
                    let content = message.message
                    if message != self.messages.last {
                        let chatMessage = ChatBit(role: role, content: content)
                        body.append(chatMessage)
                    }
                }
                
                do {
                    let jsonData = try JSONEncoder().encode(ChatRequest(messages: body, tokens: Database.shared.totalTokens, limit: AppModel.shared.storeManager.isPremium() ? 1000000 : 5000))
                    request.httpBody = jsonData
                    // Set the request headers
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
                } catch {
                   print(error)
                    self.messages.removeLast()
                    self.messages.append( error_message )
                    self.isChat = true
                    return
                    
                }
                
               

                // 3. Create a URLSessionDataTask
                URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
                    guard let data = data else {
                        DispatchQueue.main.async {
                            self?.messages.removeLast()
                            self?.messages.append( error_message )
                            self?.isChat = true
                        }
                        
              
                        return
                    }
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 440 { //the code for too many tokens 
                            
                            self?.messages.removeLast()
                            self?.messages.append( ChatMessage(is_aibot: true, message: Locale.current.language.languageCode?.identifier ?? "en" == "en" ? "Please subscribe to Chester Plus or purchase more units in the store to ask more requests for the month" : "Por favor compra Chester Plus. Necesitas mas unidades hablar con Chester mas", timestamp: "") )
                            self?.isChat = true
                            return
                        }
                    }
                        
                    do {
                        let message = try JSONDecoder().decode(MessageModel.self, from: data)
                        DispatchQueue.main.async {
                            withAnimation {
                                DispatchQueue.main.async {
                                    
                                    Database.shared.createTokenLedger(Database.shared.tokenContainer.viewContext, message.tokens, false)
                                    Database.shared.totalTokens += message.tokens
                                    let response_msg = ChatMessage(is_aibot: message.is_bot, message: message.content, timestamp: datetime_to_string(Date()))
                                    self?.messages.removeLast()
                                    self?.messages.append(response_msg)
                                    self?.isChat = true
                                }
                                
            
                            }
                            
                        }
                    } catch {
                        print(error)
                        DispatchQueue.main.async {
                            self?.messages.removeLast()
                            self?.messages.append( error_message )
                  
                        }
                    }
                }.resume()
            }
        }
        
        
        
    }
}
func load() -> [ChatMessage] {
    return []
}
