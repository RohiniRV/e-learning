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

//    @State private var course = mockCourses[0]
    
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
        .onAppear(perform: {
//            course = viewModel.courses.first(where: {$0.id == id })!
        })
        .onDisappear(perform: {
            updateCourseList()
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
    
    func updateCourseList() {
        viewModel.courses.forEach { course in
            if course.isFav || course.isAddedToCart {
                let courseEntity = CourseObject(context: moc)
                
                courseEntity.isFav = course.isFav
                courseEntity.id = course.id
                courseEntity.user = user
                courseEntity.name = course.name
                courseEntity.details = course.description
                courseEntity.isInCart = course.isAddedToCart
                courseEntity.costPrice = course.originalPrice
                courseEntity.sellingPrice = course.price
                courseEntity.image = course.image
                print("CourseEntity \(course.id)")
            }
            
        }
    }
    
    func getData(from array: [Int]) -> Data {
        var data: Data = .init()
        do {
           data = try NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false)
        }
        catch {
            print("GetData: \(error)")
        }
        return data
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
            //it should addto fav Toggle  {
            if course.isFav {
                scaleAmt = 1.0
                viewModel.removeFromWishList(course: course)
            }
            else {
                viewModel.addToWishlist(course: course)
                scaleAmt = 1.5
            }
        } label: {
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
        }
        .buttonStyle(.plain)
        .scaleEffect(scaleAmt)
        .animation(.linear(duration: 0.1).delay(0.1).repeatCount(5), value: scaleAmt)
        .onAppear {
            scaleAmt = course.isFav ? 1.5 : 1.0
        }
//        .disabled(course.isFav)
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
            if course.isAddedToCart {
                animateCartTitle = false
                viewModel.removeFromCart(course: course)
            }
            else {
                animateCartTitle = true
                viewModel.addToCart(course: course)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showNewCartTitle = true
                animateCartTitle = false
            }
        } label: {
            HStack {
                if course.isAddedToCart || showNewCartTitle {
                    Image(systemName: "cart.fill")
                }
                Text((showNewCartTitle || course.isAddedToCart) ? "In Cart" : "Add to cart")
                    .font(.title3)
                    .bold()
                    .colorInvert()
                    
            }
            .animation((animateCartTitle || showNewCartTitle) ? .easeIn(duration: 0.2) : .none, value: animationAmount)
        }
        .buttonStyle(.plain)
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 50, alignment: .center)
        .background(Color.appGreen)
        .cornerRadius(16)
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
