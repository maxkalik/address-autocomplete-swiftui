//
//  ViewModel.swift
//  AddressAutocomplete
//
//  Created by Maksim Kalik on 11/27/22.
//

import Foundation
import MapKit

struct AddressResult: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

class ContentViewModel: NSObject, ObservableObject {
    
    @Published private(set) var results: Array<AddressResult> = []
    @Published var searchableText = ""

    private lazy var localSearchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        return completer
    }()
    
    func searchAddress(_ searchableText: String) {
        localSearchCompleter.queryFragment = searchableText
    }
}

extension ContentViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        Task { @MainActor in
            results = completer.results.map {
                AddressResult(title: $0.title, subtitle: $0.subtitle)
            }
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}
