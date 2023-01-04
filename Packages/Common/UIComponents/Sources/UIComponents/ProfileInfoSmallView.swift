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
    private let email: String
    private let username: String
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
        email: String,
        username: String,
        imageURL: URL?,
        mode: ProfileInfoSmallViewMode
    ) {
        self.email = email
        self.username = username
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
                Text(email)
                Text(username)
            }
            Spacer()
        }
        .padding()
        .background(Color("BackgroundSecondary"))
        .foregroundColor(Color("TextPrimary"))
        .cornerRadius(8)
    }
}
