//
//  ContentView.swift
//  InteractiveStorybook
//
//  Created by Satvik  Jadhav on 4/1/25.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var namespace
    
    var body: some View {
        TabView {
            ForEach(storyPages, id: \.id) { page in
                PageView(page: page, namespace: namespace)
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
