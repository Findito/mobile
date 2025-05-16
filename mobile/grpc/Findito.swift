//
//  Findito.swift
//  mobile
//
//  Created by Andrzej Wójciak on 16/05/2025.
//

import ArgumentParser
import Foundation
import GRPCCore
import GRPCNIOTransportHTTP2

struct Findito: AsyncParsableCommand {
    @Flag
    var server: Bool = false


    func run() async throws {
      try await self.runClient()
    }
    
    internal func reportAnItem<Transport: GRPCCore.ClientTransport>(using serviceClient: Findito_FinditoService.Client<Transport>) async throws {
        var request = Findito_ReportFoundItemRequest()
        request.name = "Lost Smartphone"
        request.description_p = "Black iPhone"
        var location = self.createLocation(lat: 50.022, lon: 19.911)
        request.location = location

        print("Sending ReportFoundItemRequest: \(request.name)")

        do {
            let response = try await serviceClient.reportFoundItem(request)
            print("ReportFoundItemResponse received:")
            print("  Success: \(response.success)")
            print("  Item ID: \(response.itemID)")
            print("  Message: \(response.message)")
        } catch {
            print("Error calling ReportFoundItem: \(error)")
        }
    }
    
    internal func searchItemsAlongRoute<Transport: GRPCCore.ClientTransport>(using serviceClient: Findito_FinditoService.Client<Transport>) async throws {
        var request = Findito_SearchItemsAlongRouteRequest()
        var location1 = self.createLocation(lat: 50.022, lon: 19.911)
        var location2 = self.createLocation(lat: 50.060, lon: 19.935)
        
        request.routePoints = [location1, location2]
        request.searchRadiusMeters = 1000
        request.maxAgeSeconds = 3600
        
        print("Sending SearchItemsAlongRoute")
        
        do {
            let response = try await serviceClient.searchItemsAlongRoute(request)
            print("SearchItemsAlongRoute received:")
            for item in response.items {
                print("  Item name: \(item.name)")
                print("  Item descrption: \(item.description_p)")
            }
            
        }
        
    }
    
    internal func trackNearbyItems<Transport: GRPCCore.ClientTransport>(using serviceClient: Findito_FinditoService.Client<Transport>) async throws {
        print("Starting TrackNearbyItems stream using v2.x API...")

        try await serviceClient.trackNearbyItems(
            // This closure is called by grpc-swift to handle sending requests
            requestProducer: { writer in
                // --- Client Sending Logic (Inside the requestProducer closure) ---
                 print("Request producer started. Sending location updates...")

                // Simulate sending a few location updates
                let sampleLocations: [Findito_Location] = [
                    // Example: moving slightly from Krakow Main Square area
                    self.createLocation(lat: 50.061, lon: 19.936),
                    self.createLocation(lat: 50.060, lon: 19.935),
                    self.createLocation(lat: 50.059, lon: 19.934),
                    self.createLocation(lat: 50.058, lon: 19.933),
                ]

                for location in sampleLocations {
                    var update = Findito_LocationUpdate()
                    update.location = location

                    print("Producer sending LocationUpdate: (\(location.latitude), \(location.longitude))")
                    // Use the writer provided *to this closure* to send messages
                    try await writer.write(update)

                    // Simulate a delay between updates (this is necessary to see messages being sent over time)
                    try await Task.sleep(nanoseconds: 2_000_000_000) // Sleep for 2 seconds
                }

            },
            // This closure is called by grpc-swift to handle the server's response stream
            onResponse: { response in
                // --- Client Receiving Logic (Inside the onResponse closure) ---
                 print("Response handler started. Listening for FoundItems...")

                // 'response.responseStream' is the AsyncSequence of messages from the server.
                // Iterate over it to process received items.
                for try await foundItem in response.messages {
                    print("Response handler received FoundItem:")
                    print("  Name: \(foundItem.name)")
                    print("  Description: \(foundItem.description_p)")
                    print("  Location: (\(foundItem.location.latitude), \(foundItem.location.longitude))")
                }

                 print("Response handler finished receiving FoundItems. Server stream closed.")

                // The onResponse closure must return a value. If you just want to run
                // the stream and don't need a specific final result value from the client's
                // processing logic, you can return Void ().
                return () // Explicitly return Void

            }
        ) // The `await` on `serviceClient.trackNearbyItems(...)` will suspend until both the
          // requestProducer finishes AND the onResponse handler finishes consuming the response stream.


        print("TrackNearbyItems stream completed.")
        
    }
    
    
    // Helper func's
    private func createLocation(lat: Double, lon: Double) -> Findito_Location {
        var location = Findito_Location()
        location.latitude = lat
        location.longitude = lon
        return location
    }

}
