//
//  CourseDetailView.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import SwiftUI
import CoreData

struct CourseDetailView: View {
    
    var user: User
    var pageType: pageType
    var course: Course
    @EnvironmentObject var viewModel: CoursesViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State private var animationAmount = 1.0
    @State private var animateCartTitle = false
    @State private var showNewCartTitle = false
    @State private var scaleAmt = 1.0

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Divider()
            courseImageView
            detailsView
            Spacer()
            addToCartBtn
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationTitle(Text("Course Detail"))
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear(perform: {
            saveToCoredata()
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backBtn
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                wishlistBtn
            }
        }
    }
    
    var backBtn: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                switch pageType {
                case .courses:
                    Text("Courses")
                case .wishlist:
                    Text("Wishlist")
                default:
                    Text("Cart")

                }
            }
        }
        .buttonStyle(.plain)
        .foregroundColor(.indigo)
    }
    
    var wishlistBtn: some View {
        Button {
            viewModel.addToWishList(course: course, user: user)
            scaleAmt = 1.5
            if !user.wishlistCourses_Ids.contains(course.id) {
                do {
                    let courseIds = viewModel.wishlistCourses.map({$0.id})
                    for (i, _) in courseIds.enumerated() {
                        viewModel.wishlistCourses[i].isFav = true
                    }
                    user.wishlist = try NSKeyedArchiver.archivedData(withRootObject: courseIds, requiringSecureCoding: true)
                } catch {
                    print("failed to archive array with error: \(error)")
                }
                saveToCoredata()
            }
        } label: {
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
        }
        .buttonStyle(.plain)
        .scaleEffect(scaleAmt)
        .animation(.linear(duration: 0.1).delay(0.1).repeatCount(5), value: scaleAmt)
        .disabled(course.isFav)
    }
    
    var courseImageView: some View {
        Image(course.image)
            .resizable()
            .scaledToFit()
            .frame(height: UIScreen.main.bounds.height * 0.3, alignment: .center)
            .cornerRadius(16)
            .padding(.top)
    }
    
    var detailsView: some View {
        VStack(alignment: .leading) {
            Text(course.name)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.indigo)
                .padding(.vertical)
            Text("Course Description:")
                .font(.title3)
                .fontWeight(.medium)
                .padding(.bottom)
            Text(course.description)
                .font(.body)
            
            HStack {
                Text("Price:")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.vertical)
                Text("Rs." + "\(course.price)" + "/-")
                    .foregroundColor(.red)
            }
        }
    }
    
    var addToCartBtn: some View {
        Button {
            viewModel.addToCart(course: course, user: user)
            animateCartTitle = true
            if !user.cartCourses_Ids.contains(course.id) {
                do {
                    let courseIds = viewModel.cartCourses.map({$0.id})
                    for (i, _) in courseIds.enumerated() {
                        viewModel.cartCourses[i].isAddedToCart = true
                    }
                    user.cartItems = try NSKeyedArchiver.archivedData(withRootObject: courseIds, requiringSecureCoding: true)
                } catch {
                    print("failed to archive array with error: \(error)")
                }
                saveToCoredata()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showNewCartTitle = true
                animateCartTitle = false
            }
        } label: {
            HStack {
                if course.isAddedToCart {
                    Image(systemName: "cart.fill")
                }
                Text((showNewCartTitle || course.isAddedToCart) ? "In Cart" : "Add to cart")
                    .font(.title3)
                    .bold()
                    .colorInvert()
                    
            }
//            .offset(x: animateCartTitle ? UIScreen.main.bounds.width * 0.9 : 0)
//            .transition((animateCartTitle || showNewCartTitle) ? .asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)) : .identity)
            .animation((animateCartTitle || showNewCartTitle) ? .easeIn(duration: 0.2) : .none, value: animationAmount)
          
        }
        .buttonStyle(.plain)
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 50, alignment: .center)
        .background(Color.appGreen)
        .cornerRadius(16)
        .disabled(course.isAddedToCart)
        .padding()
    }
    
    func saveToCoredata() {
        do {
            try moc.save()
            print("Changes saved to coredata...")
        }
        catch {
            print("\(error.localizedDescription)")
        }
    }
}
