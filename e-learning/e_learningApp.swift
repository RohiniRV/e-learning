//
//  e_learningApp.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import SwiftUI

@main
struct e_learningApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LoginView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
