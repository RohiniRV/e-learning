//
//  AppNavigationState.swift
//  e-learning
//
//  Created by rvaidya on 25/11/21.
//

import Foundation
import Combine

class AppState: ObservableObject {
    @Published var moveToDashboard: Bool = false
}
