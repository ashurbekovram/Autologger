//
//  ProfileInfoSmallView.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import SwiftUI

public enum ProfileInfoSmallViewMode {
    case small
    case large
}

public struct ProfileInfoSmallView: View {
    private let name: String
    private let secondName: String
    private let imageURL: URL?
    private let mode: ProfileInfoSmallViewMode

    private var imageSize: CGFloat {
        switch mode {
        case .small:
            return 40.0
        case .large:
            return 60.0
        }
    }

    public init(
        name: String,
        secondName: String,
        imageURL: URL?,
        mode: ProfileInfoSmallViewMode
    ) {
        self.name = name
        self.secondName = secondName
        self.imageURL = imageURL
        self.mode = mode
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(
                url: imageURL
            ) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: imageSize, height: imageSize)
            .cornerRadius(4)
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                Text(secondName)
            }
            Spacer()
        }
        .padding()
        .background(Color("BackgroundSecondary"))
        .foregroundColor(Color("TextPrimary"))
        .cornerRadius(8)
    }
}
