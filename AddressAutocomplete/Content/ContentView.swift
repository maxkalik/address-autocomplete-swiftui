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
                    .padding()
                    .autocorrectionDisabled()
                    .focused($isFocusedTextField)
                    .font(.title)
                    .onReceive(
                        viewModel.$searchableText.debounce(
                            for: .seconds(1),
                            scheduler: DispatchQueue.main
                        )
                    ) {
                        viewModel.searchAddress($0)
                    }
                    .background(Color.init(uiColor: .systemBackground))
                    .overlay {
                        ClearButton(text: $viewModel.searchableText)
                            .padding(.trailing)
                            .padding(.top, 8)
                    }
                    .onAppear {
                        isFocusedTextField = true
                    }
                List(self.viewModel.results) { address in
                    AddressRow(address: address)
                        .listRowBackground(backgroundColor)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .background(backgroundColor)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    var backgroundColor: Color = Color.init(uiColor: .systemGray6)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
