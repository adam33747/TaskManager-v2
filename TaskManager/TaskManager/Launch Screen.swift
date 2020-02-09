//
//  Loading2.swift
//  TaskManager
//
//  Created by Adam Hu on 2/7/20.
//  Copyright © 2020 Adam Hu. All rights reserved.
//

import SwiftUI

struct LaunchScreen: View {
    @State var rotateRect = false
    @State var animateTrimPath = false
    var body: some View {
        ZStack {
            Rectangle()
            
                .trim(from: animateTrimPath ? 1/21: 0, to: animateTrimPath ? 1/21: 0.99)
            .stroke(Color.blue, lineWidth: 7)
                .background(Color.blue)
                .cornerRadius(30)
            .frame(width: 200, height: 200)
                .rotationEffect(.degrees(rotateRect ? 0: -360))
                .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false))
                
                .onAppear() {
                    self.animateTrimPath.toggle()
            }
            
            Image("checkmark-1").resizable()
                
                .frame(width: 100, height: 100)
                
                .animation(Animation.easeIn(duration: 1.5))
            
        }
            .scaleEffect(0.3, anchor: .center)
            //.animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false))
        .onAppear() {
                self.rotateRect.toggle()
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
