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
    @ObservedObject var viewModel: ViewModel

    @State private var showMakePicker: Bool = false
    @State private var showYearPicker: Bool = false

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            } else {
                VStack {
                    if let error = viewModel.error {
                        Text(error.localizedDescription)
                            .foregroundColor(.red)
                            .font(.system(size: 16, weight: .semibold, design: .default))
                        Button("Try again") {
                            viewModel.fetchMakes()
                        }
                    } else {
                        HStack {
                            Button("Select make") {
                                withAnimation {
                                    showMakePicker.toggle()
                                }
                            }
                            Spacer()
                            Text(viewModel.selectedMake?.name ?? "None")
                        }
                        if showMakePicker {
                            Picker("Select make", selection: $viewModel.selectedMake) {
                                Text("No make").tag(nil as Make?)
                                ForEach(viewModel.makes) { make in
                                    Text(make.name).tag(make as Make?)
                                }
                            }
                            .pickerStyle(.wheel)
                        }

                        HStack {
                            Button("Select year") {
                                withAnimation {
                                    showYearPicker.toggle()
                                }
                            }
                            Spacer()
                            Text(viewModel.selectedYear.description)
                        }
                        if showYearPicker {
                            Picker("Select year", selection: $viewModel.selectedYear) {
                                ForEach(viewModel.years, id: \.self) { year in
                                    Text(year.description)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        TextField("Enter Model", text: $viewModel.model)
                        TextField("Enter VIN", text: $viewModel.vin)
                        Button("Save") {
                            viewModel.save()
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(Color("BackgroundSecondary"))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
        .background(Color("BackgroundPrimary"))
        .navigationTitle("Edit auto")
        .onAppear {
            viewModel.fetchMakes()
        }
        .onDisappear {
            print("View onDisappear")
        }
    }
}


final class EditAutoViewModelMock: EditAutoViewModelProtocol {
    @Published var isLoading: Bool = false
    @Published var error: Error? = nil
    @Published var makes: [Make] = []
    @Published var years: [Int] = [2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013]

    @Published var selectedMake: Make? = nil
    @Published var selectedYear: Int = 2005
    @Published var model: String = ""
    @Published var vin: String = ""

    func fetchMakes() {
    }

    func save() {
    }
}

struct EditAutoView_Previews: PreviewProvider {
    static var previews: some View {
        EditAutoView(viewModel: EditAutoViewModelMock())
    }
}
