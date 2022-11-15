//
//  LocationsViewModel.swift
//  SwiftMap
//
//  Created by Tibirica Neto on 2022-11-15.
//
import SwiftUI
import Foundation
import MapKit

@MainActor
class LocationsViewModel: ObservableObject {
    @Published var locations: [Location]
    @Published var mapLocation: Location {
        didSet {
            updatedMapRegion(location: mapLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var showLocationList: Bool = false
    
    init() {
        let location = LocationsDataService.locations
        self.locations = location
        self.mapLocation = location.first!
        self.updatedMapRegion(location: location.first!)
    }
    
    private func updatedMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude), span: mapSpan)
        }
        
    }
    
    func toogleLocaltionList() {
        withAnimation(.easeIn) {
            showLocationList = !showLocationList
        }
    }
    
    func showNextLocation(localtion: Location) {
        withAnimation(.easeInOut) {
            mapLocation = localtion
            showLocationList = false
        }
    }
    
    func nextButtonPressed() {
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation } ) else {return}
        
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            guard let firstLocation = locations.first else {return}
            showNextLocation(localtion: firstLocation)
            return
        }
                
        let nextLocation = locations[nextIndex]
        showNextLocation(localtion: nextLocation)
    }
}
