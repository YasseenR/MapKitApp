//
//  ContentView.swift
//  MapKitApp
//
//  Created by Yasseen Rouni on 8/19/24.
//

import MapKit
import SwiftUI
import Foundation

struct Arrival: Codable {
    let route: String
    let direction: String
    let service_type: String
    let destination: String
    let arrival_time: String
    let status: String
}





struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}


class ArrivalViewModel: ObservableObject {
    @Published var arrivals: [Arrival] = []
    
    func fetchArrivals(station: String) {
        let urlString = "https://www3.septa.org/api/Arrivals/index.php?station=\(station)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decodedArrivals = try JSONDecoder().decode([Arrival].self, from: data)
                    DispatchQueue.main.async {
                        self.arrivals = decodedArrivals
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
}


struct ContentView: View {
    
    @StateObject var arrivalViewModel = ArrivalViewModel()
    
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
                        Marker(location.name, systemImage: "train.side.front.car", coordinate: location.coordinate)
                            .tint(.black)
                            
                            
                        
                    }
                }
                
                
                    
                
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
