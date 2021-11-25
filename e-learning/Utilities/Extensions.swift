//
//  Extensions.swift
//  e-learning
//
//  Created by rvaidya on 23/11/21.
//

import Foundation

extension Double {
    func rounded(toPlaces n: Int) -> Double {
        let multiplier = pow(10, Double(n))
        return (multiplier * self).rounded()/multiplier
    }
}
