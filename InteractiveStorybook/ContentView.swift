//
//  ContentView.swift
//  InteractiveStorybook
//
//  Created by Satvik  Jadhav on 4/1/25.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var namespace
    @State private var currentPageIndex = 0
    @State private var isFlipping = false
    @GestureState private var dragOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            if currentPageIndex < storyPages.count {
                PageView(page: storyPages[currentPageIndex], namespace: namespace)
                    .rotation3DEffect(
                        Angle(degrees: isFlipping ? 180 : 0),
                        axis: (x: 0, y: 1, z: 0),
                        anchor: .leading,
                        perspective: 1
                    )
                    .gesture(
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation
                            }
                            .onEnded { value in
                                if value.translation.width < -100 && currentPageIndex < storyPages.count - 1 {
                                    withAnimation(.easeInOut(duration: 0.6)) {
                                        isFlipping = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        currentPageIndex += 1
                                        isFlipping = false
                                    }
                                }
                                if value.translation.width > 100 && currentPageIndex > 0 {
                                    withAnimation(.easeInOut(duration: 0.6)) {
                                        isFlipping = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        currentPageIndex -= 1
                                        isFlipping = false
                                    }
                                }
                            }
                    )
                    .animation(.easeInOut, value: isFlipping)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
