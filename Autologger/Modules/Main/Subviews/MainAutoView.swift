//
//  MainAutoView.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 01.07.2022.
//

import Models
import SwiftUI

struct MainAutoView: View {
    private let auto: Auto

    init(auto: Auto) {
        self.auto = auto
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(auto.brand)
                Text(auto.model)
                Text(auto.year.description)
            }
            Spacer()
        }
        .padding()
        .contentShape(Rectangle())
        .background(Color("BackgroundSecondary"))
        .foregroundColor(Color("TextPrimary"))
        .cornerRadius(8)
    }
}
