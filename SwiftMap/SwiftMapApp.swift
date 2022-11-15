//
//  SwiftMapApp.swift
//  SwiftMap
//
//  Created by Tibirica Neto on 2022-11-15.
//

import SwiftUI

@main
struct SwiftMapApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}
