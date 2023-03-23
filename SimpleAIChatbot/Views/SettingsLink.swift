//
//  SettingsLink.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/7/23.
//

import SwiftUI

struct SettingsLink: View {
    var title: LocalizedStringKey
    var url: String
    var body: some View {
        Link(title, destination: URL(string: url)!)
            .font(.title)
            .foregroundColor(.blue)
            .padding()
    }
}

struct SettingsLink_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLink(title: LocalKey.about, url: "google.com")
            .environment(\.locale, .init(identifier: "es"))
    }
}
