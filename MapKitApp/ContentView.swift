//
//  ContentView.swift
//  MapKitApp
//
//  Created by Yasseen Rouni on 8/19/24.
//

import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}


struct ContentView: View {
    
    let locations = [
        Location(name: "Jefferson Station", coordinate: CLLocationCoordinate2D(latitude: 39.9525, longitude: -75.1581)),
        Location(name: "Suburban Station", coordinate: CLLocationCoordinate2D(latitude: 39.9541, longitude: -75.1669))
    ]
    
    @State private var position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.9526, longitude: -75.165222), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    
    
    var body: some View {
        VStack {
            MapReader { proxy in
                Map(position: $position) {
                    ForEach(locations) { location in
                        Marker(location.name, coordinate: location.coordinate)
                            
                        
                    }
                }
                
                
                    
                
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
