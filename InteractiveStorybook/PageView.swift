//
//  PageView.swift
//  InteractiveStorybook
//
//  Created by Satvik  Jadhav on 4/1/25.
//

import SwiftUI

struct PageView: View {
    let page: StoryPage
    let namespace: Namespace.ID
    @State private var isVisible = false
    @State private var showHiddenObject = false
    @State private var characterPosition = CGPoint(x: 100, y: 100)
    @State private var finalScale: CGFloat = 1.0
    @State private var finalRotation: Angle = .zero
    @GestureState private var scale: CGFloat = 1.0
    @GestureState private var rotation: Angle = .zero
    @State private var isJumping = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(page.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                
                Image("sun")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .matchedGeometryEffect(id: "sun", in: namespace)
                    .position(x: geometry.size.width * (0.2 + Double(page.id - 1) * 0.1), y: 50)
                
                if page.id == 1 {
                    if showHiddenObject {
                        Image("hiddenObject")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .position(x: geometry.size.width * 0.7, y: geometry.size.height * 0.3)
                    }
                    Color.clear
                        .frame(width: 100, height: 100)
                        .position(x: geometry.size.width * 0.3, y: geometry.size.height * 0.5)
                        .onTapGesture {
                            withAnimation {
                                showHiddenObject.toggle()
                            }
                        }
                    Image(page.characterImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.5)
                        .offset(y: isJumping ? -50 : 0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isJumping)
                        .position(CGPoint(x: 200, y: 200))
                    
                    Spacer()
                    
                    Text(page.text)
                            .font(.title)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(10)
                            .opacity(isVisible ? 1 : 0)
                            .offset(y: 20)
                            .padding(.bottom, 20) // Adds space from the bottom edge
                    
                    Button("Jump") {
                        print("Jump button tapped")
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                            isJumping = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                isJumping = false
                            }
                        }
                    }
                    .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.8)
                    .colorInvert()
                }
                else if page.id == 2 {
                    Image(page.characterImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .position(characterPosition)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    characterPosition = value.location
                                }
                        )
                    Text(page.text)
                        .font(.title)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                        .opacity(isVisible ? 1 : 0)
                }
                else if page.id == 3 {
                    let magnificationGesture = MagnificationGesture()
                        .updating($scale) { value, state, _ in
                            state = value
                        }
                        .onEnded { value in
                            finalScale *= value
                        }
                    let rotationGesture = RotationGesture()
                        .updating($rotation) { value, state, _ in
                            state = value
                        }
                        .onEnded { value in
                            finalRotation += value
                        }
                    Image(page.characterImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .scaleEffect(finalScale * scale)
                        .rotationEffect(finalRotation + rotation)
                        .gesture(magnificationGesture.simultaneously(with: rotationGesture))
                        .position(CGPoint(x: 200, y: 200))

                    Text(page.text)
                        .font(.title)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                        .opacity(isVisible ? 1 : 0)
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isVisible = true
                }
            }
            .onDisappear {
                isVisible = false
                showHiddenObject = false
                characterPosition = CGPoint(x: 100, y: 100)
                finalScale = 1.0
                finalRotation = .zero
                isJumping = false
            }
        }
    }
}
