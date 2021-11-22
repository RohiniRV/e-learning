//
//  ViewModifiers.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import SwiftUI

struct CustomTextField: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(16)
    }
}


