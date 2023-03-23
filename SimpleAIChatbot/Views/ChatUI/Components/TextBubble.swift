//
//  TextBubble.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 2/8/23.
//

import SwiftUI

struct TextBubble: View {
    @State var chatData: ChatMessage
    @State var showCopyMessage: Bool = false
    let pasteboard: UIPasteboard = UIPasteboard.general
    var is_same_date: Bool
    
    var body: some View {
        ZStack{
            VStack {
            
                HStack{
                    if (!chatData.is_aibot){
                        Spacer()
                    }
                    
                    Text(chatData.message)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(get_color( chatData))
                        .cornerRadius(.pi*5)
                        .padding(chatData.is_aibot ? .trailing : .leading, 40)
                        .onTapGesture {
                            //So it doesn't mess with scrollview
                        }
                        .onLongPressGesture(minimumDuration: 1.0){
                       
                                    pasteboard.string = chatData.message
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.success)
                                    withAnimation {
                                        showCopyMessage.toggle()
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                        withAnimation {
                                            showCopyMessage.toggle()
                                        }
                                        
                                    })
                                    
                                    
                                }
                        
                    
                    
                    
                    if(chatData.is_aibot){
                        Spacer()
                        EmptyView()
                            .frame(width: 20)
                    }
                }.padding(10)
                
                
                
            }
            
            Text("Succesfully copied to clipboard")
                .font(.callout)
            
                .padding()
                .background(.gray.opacity(0.8))
                .containerShape(RoundedRectangle(cornerRadius: 5))
                .opacity(showCopyMessage ? 1.0 : 0)
            
            
            
            
            
        }
        
    }
}
func get_color(_ chatMessage: ChatMessage) -> Color {
    if chatMessage.is_aibot {
        return .blue
    } else {
        return .green
    }
}
struct TextBubble_Previews: PreviewProvider {
    static var previews: some View {
        TextBubble(chatData: ChatMessage(is_aibot: true, message: "Hi Jarvis, how are you? It's been such a long time since the very last time I have meet you. Now I am just filling in text to make sure the width is looking alright. I am now just running out of ideas of how large this is going to be, but oh well a pirate's life for me.", timestamp: datetime_to_string(Date())), is_same_date: false)
    }
}
