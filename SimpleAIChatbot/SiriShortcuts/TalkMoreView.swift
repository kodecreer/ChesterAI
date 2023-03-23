//
//  TalkMoreView.swift
//  SimpleAIChatbot
//
//  Created by Kode Creer on 3/8/23.
//

import SwiftUI

struct TalkMoreView: View {
    @EnvironmentObject var modelData: ModelData
    
    var answer: String
    var body: some View {
        VStack {
            Text(LocalKey.siriUnits)
                .font(.largeTitle)
                .lineLimit(100)
            Text("\(Int(Float(Database.shared.totalTokens) / Float(1000) * 100.0))%")
                .font(.title2)
            GeometryReader { screen in
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.gray)
                    .frame(width: screen.size.width, height: 30)
                withAnimation {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.green)
                        .frame(width: screen.size.width * CGFloat(Database.shared.totalTokens)/CGFloat(AppModel.shared.storeManager.isPlus ? 1000000 : 5000)-1, height: 25)
                        .offset(x: 1, y: 2.5)
                }
                    
            }
        }
        

        
       
    }
}

struct TalkMoreView_Previews: PreviewProvider {
    static var previews: some View {
        TalkMoreView(answer: "I am a gangster")
            .environmentObject(AppModel.shared.modelData)
            .environmentObject(Database.shared)
    }
}
