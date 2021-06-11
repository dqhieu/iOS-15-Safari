//
//  AddressBar.swift
//  iOS_15_Safari
//
//  Created by Dinh Quang Hieu on 12/6/21.
//

import SwiftUI

struct AddressBar: View {

    @Namespace var animation

    @State var showSheet = false
    @Binding var isMinimized: Bool
    @Binding var url: URL
    @State var text = ""

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Button {
                    if isMinimized {
                        withAnimation(.spring()) {
                            isMinimized.toggle()
                        }
                    } else {
                        withAnimation(.spring()) {
                            showSheet = true
                        }
                    }
                } label: {
                    HStack(spacing: 4) {
                        if isMinimized {
                            Spacer()
                        }
                        Text(text).foregroundColor(.primary)
                        Image(systemName: "lock.fill").foregroundColor(.secondary)
                        Spacer()
                    }
                    .animatableFont(size: isMinimized ? 12 : 16)
                    .padding(.leading, isMinimized ? 0 : 16)
                    .padding(.top, isMinimized ? -10 : 0)
                }
                .frame(height: 50)
                .background(Blur())
                .cornerRadius(isMinimized ? 0 : 15)
                .shadow(color: .black.opacity(0.3), radius: 40, x: 2, y: 2)
                .padding(.all, isMinimized ? 0 : 16)
                .matchedGeometryEffect(id: "AddressBar", in: animation)
            }
            .edgesIgnoringSafeArea(isMinimized ? .bottom : .top)
            .zIndex(1)

            if showSheet {
                Color(.systemBackground)
                    .overlay(VStack {
                        HStack {
                            Spacer()
                            Button {
                                withAnimation(.spring()) { showSheet = false }
                            } label: {
                                Text("Cancel")
                            }
                        }
                        .padding(.top, 60)
                        .padding(.trailing)
                        VStack {
                            TextField("", text: $text, onCommit: {
                                url = URL(string: text)!
                                withAnimation(.spring()) { showSheet = false }
                            })
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                        }

                            .frame(height: 50)
                            .background(Blur())
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.3), radius: 40, x: 2, y: 2)
                            .padding(.horizontal)
                            .matchedGeometryEffect(id: "AddressBar", in: animation)
                        Spacer()
                    }
                    )
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(3)
            }
        }
        .onAppear {
            text = url.absoluteString
        }
    }
}

