//
//  MenuItems.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/4/23.
//

import SwiftUI


struct MenuItems: View {
    var body: some View {
        VStack(alignment: .leading) {
            IAPButton()
                .alignmentGuide(.leading) { context in
                    context[HorizontalAlignment.leading]
                }
                
            NavigationLink {
                SettingsView()
            } label: {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                Text(LocalKey.menuSettings)
                    .font(.system(size: 26))
                    .bold()
                    .foregroundColor(.white)
            }
            NavigationLink {
                SiriCommandsView()
            } label: {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                Text(LocalKey.helpTitle3)
                    .font(.system(size: 26))
                    .bold()
                    .foregroundColor(.white)
            }
            
            HStack {
                ShareLink(item: "https://kdcreer.com"){
                    Label(LocalKey.menuShare, systemImage: "square.and.arrow.up")
                }
                    .font(.system(size: 26))
                    .bold()
                    .foregroundColor(.white)
            }
            
            
        }
        
    }
}

struct MenuItems_Previews: PreviewProvider {
    static var previews: some View {
        MenuItems()
            .background(.gray)
            .environmentObject(StoreVM())
           
    }
}
