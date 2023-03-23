//
//  IAPButton.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/6/23.
//

import SwiftUI
import StoreKit

struct IAPButton: View {
    @EnvironmentObject var storeVM: StoreVM
    @State var price: String = ""
    var body: some View {
        NavigationLink(destination: {
            SubscriptionView()
                .environmentObject(storeVM)
                .environment(\.managedObjectContext, Database.shared.tokenContainer.viewContext)
        }, label: {
            HStack{
                Image(systemName: "dollarsign.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.green)
                VStack {
                    Text(LocalKey.premium)
                        .font(.system(size: 26))
                        .bold()
                        .foregroundColor(.white)
                  
                    
                }
        }
        })
       

        
        
    }
}

struct IAPButton_Previews: PreviewProvider {
    static var previews: some View {
        IAPButton()
            .environmentObject(StoreVM())
            .background(.black)
            .environment(\.locale, .init(identifier: "es"))
     
            
    }
}
