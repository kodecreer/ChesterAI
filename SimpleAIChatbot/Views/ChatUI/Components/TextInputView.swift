//
//  TextInputView.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/4/23.
//

import SwiftUI

struct TextInputView: View {
@ObservedObject var modelData: ModelData
  @State private var text: String = ""

  var body: some View {
      VStack {
    
          HStack {
              TextField(LocalKey.chatPrompt, text: $text, axis: .vertical)
                  .font(.system(size: 24))
                  .padding()
                  .onSubmit {
                      submit()
                     
                  }
                  .disabled(!modelData.isChat)
                  .background(!modelData.isChat ? .gray : .clear)
              Button {
                  submit()
              } label: {
                  Image(systemName: "paperplane")
                      .resizable()
                      .frame(width: 30, height:30)
                      .padding(.trailing)
                      
              }

          }   
      }
         
      
    
  }
    func submit() {
        if(!text.isEmpty){
            withAnimation {
                modelData.messages.append(ChatMessage( is_aibot: false, message: text, timestamp: datetime_to_string(Date())))
                
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                text = ""
                modelData.fetch_response()
            }
            
        
        }
    }
}


struct TextInputView_Previews: PreviewProvider {
    static var previews: some View {
        TextInputView(modelData: ModelData())
    }
}
