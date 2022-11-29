//
//  AddressResult.swift
//  AddressAutocomplete
//
//  Created by Maksim Kalik on 11/29/22.
//

import Foundation

struct AddressResult: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}
