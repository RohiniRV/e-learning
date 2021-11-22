//
//  HomeView.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            CoursesView()
                .tabItem {
                    Text("Courses")
                    Image(systemName: "house.fill")
                }
            Text("Wishlist")
                .tabItem {
                    Text("Wishlist")
                    Image(systemName: "heart.fill")
                }
            Text("Profile")
                .tabItem {
                    Text("Profile")
                    Image(systemName: "person.fill")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
