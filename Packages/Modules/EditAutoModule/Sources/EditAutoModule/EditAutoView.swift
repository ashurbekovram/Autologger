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

    @State private var showBrandPicker: Bool = false
    @State private var showSeriesPicker: Bool = false
    @State private var showGenerationPicker: Bool = false
    @State private var showYearPicker: Bool = false

    public var body: some View {
        ScrollView {
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else {
                VStack {
                    VStack {
                        if let error = viewModel.error {
                            Text(error.localizedDescription)
                                .foregroundColor(.red)
                                .font(.system(size: 16, weight: .semibold, design: .default))
                            Button("Try again") {
                                viewModel.fetchBrands()
                            }
                        } else {
                            Button {
                                withAnimation {
                                    showBrandPicker.toggle()
                                }
                            } label: {
                                HStack {
                                    Text("Brand")
                                        .foregroundColor(Color("TextPrimary"))
                                    Spacer()
                                    Text(viewModel.selectedBrand?.name ?? "None")
                                }
                            }
                            if showBrandPicker {
                                Picker("Select brand", selection: $viewModel.selectedBrand) {
                                    Text("No brand").tag(nil as VehicleBrand?)
                                    ForEach(viewModel.brands) { brand in
                                        Text(brand.name).tag(brand as VehicleBrand?)
                                    }
                                }
                                .pickerStyle(.wheel)
                            }
                            Divider()
                            if let selectedBrand = viewModel.selectedBrand {
                                Button {
                                    withAnimation {
                                        showSeriesPicker.toggle()
                                    }
                                } label: {
                                    HStack {
                                        Text("Series")
                                            .foregroundColor(Color("TextPrimary"))
                                        Spacer()
                                        Text(viewModel.selectedSeries?.name ?? "None")
                                    }
                                }
                                if showSeriesPicker {
                                    Picker("Select series", selection: $viewModel.selectedSeries) {
                                        Text("No series").tag(nil as VehicleSeries?)
                                        ForEach(selectedBrand.series) { series in
                                            Text(series.name).tag(series as VehicleSeries?)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                }
                                Divider()
                            }
                            if let selectedSeries = viewModel.selectedSeries {
                                Button {
                                    withAnimation {
                                        showGenerationPicker.toggle()
                                    }
                                } label: {
                                    HStack {
                                        Text("Generation")
                                            .foregroundColor(Color("TextPrimary"))
                                        Spacer()
                                        Text(viewModel.selectedGeneration?.name ?? "None")
                                    }
                                }
                                if showGenerationPicker {
                                    Picker("Select series", selection: $viewModel.selectedGeneration) {
                                        Text("No generation").tag(nil as VehicleGeneration?)
                                        ForEach(selectedSeries.generations) { generation in
                                            Text(generation.name).tag(generation as VehicleGeneration?)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                }
                                Divider()
                            }
                            if let selectedGeneration = viewModel.selectedGeneration {
                                Button {
                                    withAnimation {
                                        showYearPicker.toggle()
                                    }
                                } label: {
                                    HStack {
                                        Text("Year")
                                            .foregroundColor(Color("TextPrimary"))
                                        Spacer()
                                        Text(viewModel.selectedYear?.description ?? "None")
                                    }
                                }
                                if showYearPicker {
                                    Picker("Select year", selection: $viewModel.selectedYear) {
                                        ForEach(selectedGeneration.startYear...selectedGeneration.endYear, id: \.self) { year in
                                            Text(year.description).tag(year as Int?)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                }
                                Divider()
                            }
                            TextField("Enter VIN", text: $viewModel.vin)
                        }
                    }
                    .padding()
                    .background(Color("BackgroundSecondary"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    Spacer(minLength: 32)
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
                .padding()
            }
        }
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
}
