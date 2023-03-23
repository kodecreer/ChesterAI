//
//  IntroPopup.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/11/23.
//

import SwiftUI

struct IntroPopup: View {
    @State var privacy: Bool = false
    @State var tos: Bool = false
    @State var isShow: Bool = true
    var body: some View {
        VStack{
            Text(LocalKey.intro)
                .padding()
                .background(.blue)
            Toggle(LocalKey.introAPP, isOn: $privacy)
                .padding()
                .background(.blue)
            
            Link(LocalKey.introAVP, destination: URL(string:"https://kdcreer.com/privacy")!)
                .foregroundColor(.blue)
            Toggle(LocalKey.introATOS, isOn: $tos)
                .padding()
                .background(.blue)
            Link(LocalKey.introVTOS, destination: URL(string: "https://kdcreer.com/tos")!)
                .foregroundColor(.blue)
            Button(action: {
                UserDefaults.standard.set(true, forKey: "isFirst")
                isShow.toggle()
            }, label: {
                Text("Submit")
            })
            .padding()
            .cornerRadius(10)
            .background((privacy && tos) ? .green : .gray)
            .disabled(!privacy || !tos)
            .foregroundColor((privacy && tos) ? .white : .gray)
                
            }.foregroundColor(.white)
            .background(.gray)
            .padding()
            .opacity(isShow ? 1.0 : 0)
            
        }
        
    
}

struct IntroPopup_Previews: PreviewProvider {
    @State var isFirst = true
    static var previews: some View {
        
        IntroPopup()
            .environment(\.locale, .init(identifier: "es"))
    }
}
