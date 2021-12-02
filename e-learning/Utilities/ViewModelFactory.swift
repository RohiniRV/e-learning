//
//  ViewModelFactory.swift
//  e-learning
//
//  Created by rvaidya on 24/11/21.
//

import Foundation

class ViewModelFactory {
    
    let networkManager = NetworkManager()

    func getCoursesViewModel(for user: User) -> CoursesViewModel {
        return CoursesViewModel(networkManager: networkManager, user: user)
    }
    
}
