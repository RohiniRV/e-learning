//
//  NavBar.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import SwiftUI

struct NavBar: View {
    @Binding var viewType: ViewType
    
    var body: some View {
        HStack {
            switch viewType {
            case .courses:
                Text("Courses")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding()
            case .wishlist:
                Text("Wishlist")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding()

            case .profile:
                Text("Profile")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding()

            case .courseDetail:
                Text("Course Detail")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding()
            }
            Spacer()
            if viewType != .wishlist {
                Button {
                    //
                } label: {
                    Image(systemName: viewType == .courses ? "cart.fill" : viewType == .courseDetail ? "heart.fill" : "pencil.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35, alignment: .center)
                }
                .buttonStyle(.plain)
                .padding()
            }
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(viewType: .constant(.courses))
    }
}

enum ViewType: String {
    case courses
    case courseDetail
    case wishlist
    case profile
}
