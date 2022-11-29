//
//  ContentView.swift
//  AddressAutocomplete
//
//  Created by Maksim Kalik on 11/27/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ContentViewModel
    @FocusState private var isFocusedTextField: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                TextField("Type address", text: $viewModel.searchableText)
                    .padding(.leading)
                    .padding(.trailing, 40)
                    .padding(.top)
                    .autocorrectionDisabled()
                    .focused($isFocusedTextField)
                    .font(.title)
                    .onReceive(
                        viewModel.$searchableText.debounce(for: .seconds(1), scheduler: DispatchQueue.main)
                    ) {
                        guard $0.isEmpty == false else { return }
                        viewModel.searchAddress($0)
                    }
                    .padding(.bottom, 10)
                    .background(Color.white)
                    .overlay {
                        if viewModel.searchableText.isEmpty == false {
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.searchableText = ""
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                                }
                                .foregroundColor(.secondary)
                                .padding(.trailing)
                                .padding(.top, 8)
                            }
                        }
                    }
                    .onAppear {
                        isFocusedTextField = true
                    }
                List(self.viewModel.results) { address in
                    NavigationLink {
                        MapView(address: address)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(address.title)
                            Text(address.subtitle)
                                .font(.caption)
                        }
                    }
                    .padding(.bottom, 2)
                    .listRowBackground(backgroundColor)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .background(backgroundColor)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    var backgroundColor: Color = Color(red: 0.95, green: 0.95, blue: 0.95)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
