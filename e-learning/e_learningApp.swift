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
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
