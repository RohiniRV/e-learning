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

extension Array {  
    func getData() -> Data {
        var data: Data = .init()
        do {
           data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)
        }
        catch {
            print("\(error)")
        }
        return data
    }
}

extension Data {
    func getArray() -> [Int] {
        var result: [Int] = []
        do {
            if let idsUnarchived = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: self) as? [Int] {
                result = idsUnarchived
            }
        } catch {
            print("\(error)")
        }
        return result
    }
    
}
