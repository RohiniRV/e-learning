//
//  HomeView.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: CoursesViewModel
    @EnvironmentObject var appState: AppState
    @Environment (\.presentationMode) var presentationMode
    
    var user: User
    
    var body: some View {
        TabView {
            CoursesView(user: user)
                .environmentObject(viewModel)
                .tabItem {
                    Text("Courses")
                    Image(systemName: "house.fill")
                }
            WishtlistView(user: user)
                .environmentObject(viewModel)
                .tabItem {
                    Text("Wishlist")
                    Image(systemName: "heart.fill")
                }
            ProfileView(user: user)
                .environmentObject(appState)
                .tabItem {
                    Text("Profile")
                    Image(systemName: "person.fill")
                }
        }
        .accentColor(.indigo)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onReceive(appState.$moveToDashboard) { shouldLogout in
            if shouldLogout {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .onAppear {
            print("Home View appears...")
        }
    }
}

enum pageType: String {
    case courses = "Courses"
    case wishlist = "Wishlist"
    case cart = "Cart"
}
