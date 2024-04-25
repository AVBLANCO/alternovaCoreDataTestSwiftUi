//
//  alternovaCoreDataTestApp.swift
//  alternovaCoreDataTest
//
//  Created by Sergio Luis Noriega Pita on 24/04/24.
//

import SwiftUI

@main
struct alternovaCoreDataTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
