//
//  LocationListView.swift
//  SwiftMap
//
//  Created by Tibirica Neto on 2022-11-15.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List(vm.locations, id: \.id) { location in
            Button {
                vm.showNextLocation(localtion: location)
            } label: {
                listRowView(location: location)
                    
            }
            .padding(.vertical, 4)
            .listRowBackground(Color.clear)
            
        }
        .listStyle(.plain)
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsListView {
    
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 55, height: 45)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
