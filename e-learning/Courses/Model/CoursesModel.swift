//
//  CoursesModel.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import Foundation


struct Course: Hashable, Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var image: String
    var price: String
    var originalPrice: String
    var isFav: Bool
}
