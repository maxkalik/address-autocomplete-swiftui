//
//  AddressAutocompleteApp.swift
//  AddressAutocomplete
//
//  Created by Maksim Kalik on 11/27/22.
//

import SwiftUI

@main
struct AddressAutocompleteApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
