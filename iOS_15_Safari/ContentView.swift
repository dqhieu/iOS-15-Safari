//
//  ContentView.swift
//  iOS_15_Safari
//
//  Created by Dinh Quang Hieu on 12/6/21.
//

import SwiftUI

struct ContentView: View {

    @State var showSheet = false
    @State var isMinimized = false

    @State var url: URL = URL(string: "https://www.apple.com")!

    var body: some View {
        ZStack {
            WebView(
                request: URLRequest(url: url),
                onMoveUp: {
                withAnimation(.spring()) {
                    isMinimized = false
                }
            }, onMoveDown: {
                withAnimation(.spring()) {
                    isMinimized = true
                }
            })
                .edgesIgnoringSafeArea(.bottom)
                .zIndex(0)
            AddressBar(isMinimized: $isMinimized, url: $url)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
