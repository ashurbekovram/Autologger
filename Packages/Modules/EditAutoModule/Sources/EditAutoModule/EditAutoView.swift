//
//  EditAutoView.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 01.07.2022.
//

import Combine
import SwiftUI
import Models

public struct EditAutoView: View {
    @StateObject private var viewModel: EditAutoViewModel

    public init(inputModel: EditAutoInputModel) {
        _viewModel = StateObject(wrappedValue: EditAutoViewModel(
            vehiclesService: inputModel.vehiclesService,
            userAutosService: inputModel.userAutosService
        ))
    }

    public var body: some View {
        ScrollView {
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else {
                if let error = viewModel.error {
                    makeErrorView(with: error)
                } else {
                    VStack {
                        makeCarSelectionSection()
                        Spacer(minLength: 16)
                        makeFieldsSection()
                        Spacer(minLength: 32)
                        makeSaveButton()
                    }
                }
            }
        }
        .padding()
        .background(Color("BackgroundPrimary"))
        .navigationTitle("Edit auto")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            viewModel.fetchBrands()
        }
        .onDisappear {
            print("View onDisappear")
        }
    }

    private func makeErrorView(with error: Error) -> some View {
        VStack {
            Text(error.localizedDescription)
                .foregroundColor(.red)
                .font(.system(size: 16, weight: .semibold, design: .default))
            Button("Try again") {
                viewModel.fetchBrands()
            }
        }
        .padding()
        .background(Color("BackgroundSecondary"))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private func makeCarSelectionSection() -> some View {
        VStack(spacing: 12) {
            Picker("Brand", selection: $viewModel.selectedBrand) {
                Text("None").tag(nil as VehicleBrand?)
                ForEach(viewModel.brands) { brand in
                    Text(brand.name)
                        .tag(brand as VehicleBrand?)
                        .foregroundColor(Color("TextPrimary"))
                }
            }
            .pickerStyle(.navigationLink)
            if let selectedBrand = viewModel.selectedBrand {
                Divider()
                Picker("Series", selection: $viewModel.selectedSeries) {
                    Text("None").tag(nil as VehicleSeries?)
                    ForEach(selectedBrand.series) { series in
                        Text(series.name)
                            .tag(series as VehicleSeries?)
                            .foregroundColor(Color("TextPrimary"))
                    }
                }
                .pickerStyle(.navigationLink)
            }
            if let selectedSeries = viewModel.selectedSeries {
                Divider()
                Picker("Select series", selection: $viewModel.selectedGeneration) {
                    Text("None").tag(nil as VehicleGeneration?)
                    ForEach(selectedSeries.generations) { generation in
                        Text(generation.name)
                            .tag(generation as VehicleGeneration?)
                            .foregroundColor(Color("TextPrimary"))
                    }
                }
                .pickerStyle(.navigationLink)
            }
            if let selectedGeneration = viewModel.selectedGeneration {
                Divider()
                makeYearPicker(with: selectedGeneration)
            }
        }
        .padding(12)
        .background(Color("BackgroundSecondary"))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private func makeYearPicker(with selectedGeneration: VehicleGeneration) -> some View {
        VStack {
            Button {
                withAnimation {
                    viewModel.showYearPicker.toggle()
                }
            } label: {
                HStack {
                    Text("Year")
                    Spacer()
                    if let selectedYear = viewModel.selectedYear {
                        Text(selectedYear.description)
                            .foregroundColor(Color("TextPrimary"))
                    } else {
                        Text("None")
                    }
                }
            }
            if viewModel.showYearPicker {
                Picker("Select year", selection: $viewModel.selectedYear) {
                    ForEach(selectedGeneration.startYear...selectedGeneration.endYear, id: \.self) { year in
                        Text(year.description).tag(year as Int?)
                    }
                }
                .pickerStyle(.wheel)
            }
        }
    }

    private func makeFieldsSection() -> some View {
        VStack {
            TextField("VIN", text: $viewModel.vin)
        }
        .padding(12)
        .background(Color("BackgroundSecondary"))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private func makeSaveButton() -> some View {
        Button {
            viewModel.save()
        } label: {
            HStack {
                Spacer()
                Text("Save").frame(height: 40, alignment: .center)
                Spacer()
            }
        }
        .background(Color("BackgroundSecondary"))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
