//
//  AppDelegate.swift
//  TestApp
//
//  Created by Maxim Potapov on 23.09.2021.
//

import Foundation
import UIKit
import Pilgrim

class AppDelegate: NSObject, UIApplicationDelegate {
    let clientId = "12FU3LQTEDE1GY1P2WBLZ0FWRGZGWIZVPEJMDLUTCPJGD0W3"
    let clientSecret = "VHDKSRYECGCEGNXD5JW0TOSOFVLRXZXVAIZPUYFWYM3IVOLF"
    let date = "\(Date())"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        PilgrimManager.shared().configure(withConsumerKey: clientId, secret: clientSecret, delegate: self, completion: nil)
        return true
    }
}

extension AppDelegate : PilgrimManagerDelegate {
    // Primary visit handler:
    func pilgrimManager(_ pilgrimManager: PilgrimManager, handle visit: Visit) {
        // Process the visit however you'd like:
        print("\(visit.hasDeparted ? "Departure from" : "Arrival at") \(visit.venue != nil ? visit.venue!.name : "Unknown venue."). Added a Pilgrim visit at: \(visit.displayName)")
    }
    
    // Optional: If visit occurred without network connectivity
    func pilgrimManager(_ pilgrimManager: PilgrimManager, handleBackfill visit: Pilgrim.Visit) {
        // Process the visit however you'd like:
        print("Backfill \(visit.hasDeparted ? "departure from" : "arrival at") \(visit.venue != nil ? visit.venue!.name : "Unknown venue."). Added a Pilgrim backfill visit at: \(visit.displayName)")
    }
    
    // Optional: If visit occurred by triggering a geofence
    func pilgrimManager(_ pilgrimManager: PilgrimManager, handle geofenceEvents: [GeofenceEvent]) {
        // Process the geofence events however you'd like. Here we loop through the potentially multiple geofence events and handle them individually:
        geofenceEvents.forEach { geofenceEvent in
            print(geofenceEvent)
        }
    }
    
    // Optional: If there is an update to the user state
    func pilgrimManager(_ pilgrimManager: PilgrimManager, handleUserState updatedUserState: UserState, changedComponents: UserStateComponent) {
        switch changedComponents {
        case .city:
            print("Welcome to \(updatedUserState.city)")
        // handle other cases
        default:
            print("Welcome to nowheare")
        }
    }
    
    // Optional: If there is an error
    func pilgrimManager(_ pilgrimManager: PilgrimManager, handle error: Error) {
        // handle any Pilgrim errors
        print(error)
    }
}

