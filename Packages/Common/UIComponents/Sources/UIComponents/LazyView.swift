//
//  LazyView.swift
//  
//
//  Created by Ramazan Ashurbekov on 31.07.2022.
//

import SwiftUI

public struct LazyView<Content: View>: View {
    private let build: () -> Content

    public var body: Content {
        build()
    }

    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
}
