//
//  PageView.swift
//  InteractiveStorybook
//
//  Created by Satvik  Jadhav on 4/1/25.
//

import SwiftUI

struct PageView: View {
    let page: StoryPage
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background image
                Image(page.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                
                // Character and text
                VStack {
                    Image(page.characterImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.5)
                    
                    Text(page.text)
                        .font(.title)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                }
            }
        }
    }
}
