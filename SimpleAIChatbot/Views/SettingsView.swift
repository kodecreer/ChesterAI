//
//  SettingsView.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/6/23.
//

import SwiftUI
import StoreKit


enum SVStr{
    
}

struct SettingsView: View {
    @EnvironmentObject var storekitManager: StoreVM
    var body: some View {
        VStack {
            Text(LocalKey.owner)
                .font(.largeTitle)
                .padding()
            //TODO: Change the email so I don't get bombed with spam
            SettingsLink(title: LocalKey.contact, url: "https://www.kdcreer.com/support")
            //Terms of Use
            SettingsLink(title: LocalKey.tos, url: "https://www.kdcreer.com/terms_of_use")
            SettingsLink(title: LocalKey.privacy, url: "https://www.kdcreer.com/privacy_policy")
            SettingsLink(title: LocalKey.about, url: "https://www.kdcreer.com/about_us")
            Button {
                //Restore Purchases
                Task {
                    try? await AppStore.sync()
                }
                
            } label: {
                Text(LocalKey.restore)
                    .font(.title)
            }

        }
       
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environment(\.locale, .init(identifier: "es"))
    }
}
