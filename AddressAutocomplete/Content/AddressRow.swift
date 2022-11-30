//
//  AddressRow.swift
//  AddressAutocomplete
//
//  Created by Maksim Kalik on 11/30/22.
//

import SwiftUI

struct AddressRow: View {
    
    let address: AddressResult
    
    var body: some View {
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
    }
}
