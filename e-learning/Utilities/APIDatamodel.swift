//
//  APIDatamodel.swift
//  e-learning
//
//  Created by rvaidya on 24/11/21.
//

import Foundation

struct HighLevelAPIDataModel: Decodable {
    var page: Int
    var per_page: Int
    var total: Int
    var total_pages: Int
    var data: [APIDataModel]
}


struct APIDataModel: Decodable {
    var id: Int
    var email: String
    var first_name: String
    var last_name: String
    var avatar: String
}
