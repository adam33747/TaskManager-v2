//
//  Loading.swift
//  TaskManager
//
//  Created by Adam Hu on 2/5/20.
//  Copyright © 2020 Adam Hu. All rights reserved.
//
import Foundation
import SwiftUI
import UIKit



struct Loading: View {
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<3) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 6, height: geometry.size.height / 6)
                        .scaleEffect(!self.isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
                        .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
                        .foregroundColor(.blue)
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                
                    .animation(Animation
                        .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                        .repeatForever(autoreverses: false))
            }
        }.aspectRatio(2, contentMode: .fit)
            .onAppear {
                self.isAnimating = true
            }
            
          
    }
        
    }
    
}
