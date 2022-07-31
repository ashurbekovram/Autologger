//
//  EditAutoView.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 01.07.2022.
//

import Combine
import SwiftUI
import MakesService
import Models
import NetworkManager

struct EditAutoView<ViewModel: EditAutoViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                Form {
                    if let error = viewModel.error {
                        Text(error.localizedDescription)
                            .foregroundColor(.red)
                            .font(.system(size: 16, weight: .semibold, design: .default))
                        Button("Try again") {
                            viewModel.fetchMakes()
                        }
                    } else {
                        Section {
                            Picker("Select make", selection: $viewModel.selectedMake) {
                                Text("No make").tag(nil as Make?)
                                ForEach(viewModel.makes) { make in
                                    Text(make.name).tag(make as Make?)
                                }
                            }
                            .pickerStyle(.menu)
                            Picker("Select year", selection: $viewModel.selectedYear) {
                                ForEach(viewModel.years, id: \.self) { year in
                                    Text(year.description)
                                }
                            }
                            .pickerStyle(.wheel)
                            TextField("Enter Model", text: $viewModel.model)
                            TextField("Enter VIN", text: $viewModel.vin)
                        }
                        Section {
                            Button("Save") {
                                viewModel.save()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Edit auto")
        .onAppear {
            viewModel.fetchMakes()
        }
        .onDisappear {
            print("View onDisappear")
        }
    }
}
