//
//  WebView.swift
//  iOS_15_Safari
//
//  Created by Dinh Quang Hieu on 12/6/21.
//

import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewRepresentable {

    let request: URLRequest
    let wkWebView: WKWebView

    var onMoveUp: (() -> Void)
    var onMoveDown: (() -> Void)

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: WebView
        var onMoveUp: (() -> Void)
        var onMoveDown: (() -> Void)

        init(_ parent: WebView, onMoveUp: @escaping (() -> Void), onMoveDown: @escaping (() -> Void)) {
            self.parent = parent
            self.onMoveUp = onMoveUp
            self.onMoveDown = onMoveDown
        }

        private var lastContentOffset: CGFloat = 0

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if (self.lastContentOffset > scrollView.contentOffset.y) {
                onMoveUp()
            }
            else if (self.lastContentOffset < scrollView.contentOffset.y) {
                onMoveDown()
            }

            self.lastContentOffset = scrollView.contentOffset.y
        }

    }

    init(request: URLRequest, onMoveUp: @escaping (() -> Void), onMoveDown: @escaping (() -> Void)) {
        self.request = request
        self.onMoveUp = onMoveUp
        self.onMoveDown = onMoveDown
        self.wkWebView = WKWebView()
    }

    func makeUIView(context: Context) -> WKWebView  {
        return wkWebView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(self, onMoveUp: onMoveUp, onMoveDown: onMoveDown)
        wkWebView.scrollView.delegate = coordinator
        return coordinator
    }
}
