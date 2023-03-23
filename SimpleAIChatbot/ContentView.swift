//
//  ContentView.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 1/31/23.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var storeVM: StoreVM
    @EnvironmentObject var database: Database

    @State var menuOpen: Bool = false
    @State var offset = CGSize.zero
    @State var isFirstTime = !UserDefaults.standard.bool(forKey: "isFirst")
    var body: some View {
        
        ZStack{
          
                ChatUI(menuOpen: $menuOpen)
                .environmentObject(modelData)
                .environmentObject(storeVM)
                .environment(\.managedObjectContext, Database.shared.tokenContainer.viewContext)
                .offset(x: menuOpen ? UIScreen.main.bounds.width/1.2+offset.width : 0)
              
                MenuTab(menuOpen: $menuOpen)
                .environmentObject(storeVM
                )
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                if gesture.translation.width < 0{
                                    offset.width = gesture.translation.width
                                }
                                
                            }
                            .onEnded { _ in
                                withAnimation {
                                    if abs(offset.width) > 50 {
                                        menuOpen.toggle()
                                        offset = .zero
                                    } else {
                                        offset = .zero
                                    }
                                }
                                
                            }
                    )
            
            if !UserDefaults.standard.bool(forKey: "isFirst"){
                IntroPopup()
            }
            
            
            
        }
        
        
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
            .environmentObject(StoreVM())
            .environmentObject(Database.shared)
            .environment(\.locale, .init(identifier: "en"))
            
    }
}
