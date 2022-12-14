//
//  MainView.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 01.07.2022.
//

// Быстрый доступ наверху

// Вкладка личной информации
// Список своих документов

// Вкладка автомобиля
// Информация по автомобилю - пробег, год, номер, вин, объем двигателя, мощность, крутящий, масса
// Документы - СТС, техпаспорт, страховка
// Траты
// Хотелки
// ТО
// Напоминалки - замена масла / колодки и тд

import Combine
import Models
import SwiftUI
import UIComponents

public struct MainView: View {
    @StateObject private var viewModel: MainViewModel

    public init(inputModel: MainInputModel) {
        _viewModel = StateObject(wrappedValue: MainViewModel(
            viewFactory: inputModel.viewFactory,
            profileService: inputModel.profileService,
            userAutosService: inputModel.userAutosService
        ))
    }

    public var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                if viewModel.isProfileLoading {
                    profilePlaceholder
                    Spacer(minLength: 8)
                } else if let profile = viewModel.profile {
                    ProfileInfoSmallView(
                        email: profile.email,
                        username: profile.username,
                        imageURL: profile.imageURL,
                        mode: .small
                    )
                    Spacer(minLength: 8)
                }

                if viewModel.isAutosLoading {
                    ForEach(0..<4) { _ in
                        autoPlaceholder
                    }
                } else {
                    ForEach(viewModel.autos) { auto in
                        NavigationLink {
                            Text("Test")
                        } label: {
                            MainAutoView(auto: auto)
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color("BackgroundPrimary"))
        .navigationTitle("Auto logger")
        .navigationBarTitleDisplayMode(.large)
        .safeAreaInset(edge: .top) {
            Spacer().frame(height: 8)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    viewModel.viewFactory.createEditAutoView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }

    private var profilePlaceholder: some View {
        ProfileInfoSmallView(
            email: "placeholder email",
            username: "placeholder username",
            imageURL: nil,
            mode: .small
        )
        .redacted(reason: .placeholder)
    }

    private var autoPlaceholder: some View {
        MainAutoView(
            auto: Auto(brand: "Mock brand", model: "Mock automodel", year: 2000, vin: "AAAAAAAAAAAA")
        )
        .redacted(reason: .placeholder)
    }
}
