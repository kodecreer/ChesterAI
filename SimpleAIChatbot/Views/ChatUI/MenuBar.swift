//
//  MenuBar.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/4/23.
//

import SwiftUI

struct MenuBar: View {
    @Binding var menuOpen: Bool
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var storeVM: StoreVM
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        VStack{
            HStack {
                    Button {
                        withAnimation {
                            menuOpen.toggle()
                            
                        }
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }.padding()
                
                    Spacer()
                
                Text(LocalKey.chatTitle)
                        .font(.largeTitle)
                        
                Image(storeVM.isPlus ? colorScheme == .dark ? "ChadChesterTransparentDark" : "ChadChesterTransparent" :  colorScheme == .dark ? "ChesterDarkMode" : "ChesterLightMode")
                        .resizable()
                        .frame(width: 60, height: 60)
                    Spacer()
                    
                
                
            }
            VStack{
                Text("menu-chat-units \(String(Database.shared.totalTokens)) \(String(storeVM.isPlus ? 1000000 : 5000))")
                    //.bold()
                GeometryReader { screen in
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.gray)
                        .frame(width: screen.size.width, height: 30)
                    withAnimation {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.green)
                            .frame(width: screen.size.width * CGFloat(Database.shared.totalTokens)/CGFloat((storeVM.isPremium() ? 1000000 : 5000)), height: 25)
                            .offset(x: 1, y: 2.5)
                    }
                    
                        
                }
            }
            .frame(height: 45)
            //.background(.red)
            
        }
        
        
    }
}

struct MenuBar_Previews: PreviewProvider {
    static var previews: some View {
        MenuBar(menuOpen: .constant(true))
            .environmentObject(ModelData())
            .environmentObject(StoreVM())
            .environment(\.locale, .init(identifier: "es"))
    }
}
