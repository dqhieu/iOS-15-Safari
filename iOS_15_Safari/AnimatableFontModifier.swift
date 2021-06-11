//
//  AnimatableFontModifier.swift
//  iOS_15_Safari
//
//  Created by Dinh Quang Hieu on 12/6/21.
//

import SwiftUI

struct AnimatableFontModifier: AnimatableModifier {
    var size: CGFloat

    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }

    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
    }
}

extension View {
    func animatableFont(size: CGFloat) -> some View {
        self.modifier(AnimatableFontModifier(size: size))
    }
}
