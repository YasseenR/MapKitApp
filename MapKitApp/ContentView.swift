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
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    
    var body: some View {
        VStack {
            MapReader { proxy in
                Map()
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            print(coordinate)
                        }
                    }
                
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
