//
//  Extensions.swift
//  e-learning
//
//  Created by rvaidya on 23/11/21.
//

import Foundation
import SwiftUI

extension Double {
    func rounded(toPlaces n: Int) -> Double {
        let multiplier = pow(10, Double(n))
        return (multiplier * self).rounded()/multiplier
    }
}

extension Color {
    static let appGreen = Color("appGreen")
}

extension UITabBarController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
    }
}
