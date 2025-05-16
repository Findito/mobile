//
//  FinditoClient.swift
//  mobile
//
//  Created by Andrzej Wójciak on 16/05/2025.
//

import GRPCCore
import GRPCNIOTransportHTTP2

extension Findito {
    func runClient() async throws {
        try await withGRPCClient(
            transport: .http2NIOPosix(
                target: .ipv4(host: "127.0.0.1", port: 50051),
                transportSecurity: .plaintext
            )
        ) { client in
            let findito = Findito_FinditoService.Client(wrapping: client)

            print("\n--- Attempting to Report an Item ---")
            try await self.reportAnItem(using: findito)
            
            print("\n--- Attempting to Search Items Along Route ---")
            try await self.searchItemsAlongRoute(using: findito)

            print("\n--- Attempting to Track Nearby Items (Bidirectional Stream) ---")
            try await self.trackNearbyItems(using: findito)
        }
    }
}
