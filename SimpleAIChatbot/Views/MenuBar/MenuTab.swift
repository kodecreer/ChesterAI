//
//  MenuTab.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/4/23.
//

import SwiftUI

struct MenuTab: View {
    @Binding var menuOpen: Bool
   
    var body: some View {
        ZStack {
                GeometryReader { screen in
                    Rectangle()
                        .frame(width: screen.size.width, height: screen.size.height)
                        .onTapGesture {
                            withAnimation {
                                menuOpen.toggle()
                            }
                            
                        }
                        .foregroundColor(.clear)
                        .background(.gray)
                        .opacity(menuOpen ? 0.5 : 0)
                        
                    HStack(alignment: .center) {
                        MenuItems()
                            .frame(width: screen.size.width/1.2, height: screen.size.height)
                            .background(.gray)
                        Spacer()
                    }
                    .offset(x: menuOpen ? 0.0: -screen.size.width)
                    .animation(.default, value: 0)
                }
            
                .animation(.easeIn, value: 0)

        }
    }
}

struct MenuTab_Previews: PreviewProvider {
    static var previews: some View {
        MenuTab(menuOpen: .constant(true))
            .environmentObject(StoreVM())
        
    }
}
