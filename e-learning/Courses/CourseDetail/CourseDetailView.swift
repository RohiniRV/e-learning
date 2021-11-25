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
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.addToWishList(course: course, user: user)
                    if !user.wishlistCourses_Ids.contains(course.id) {
                        do {
                            let courseIds = viewModel.wishlistCourses.map({$0.id})
                            
                            user.wishlist = try NSKeyedArchiver.archivedData(withRootObject: courseIds, requiringSecureCoding: true)
                        } catch {
                            print("failed to archive array with error: \(error)")
                        }
                        
                        saveToCoredata()
                    }
                    
                    print("Array of ids \(course.id)")
                } label: {
                    Image(systemName: "heart.fill")
                }
                .buttonStyle(.plain)
            }
        }
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
                .padding(.vertical)
            Text("Course Description")
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
            }
        }
    }
    
    var addToCartBtn: some View {
        Button {
            viewModel.addToCart(course: course, user: user)
            if !user.cartCourses_Ids.contains(course.id) {
                do {
                    let courseIds = viewModel.cartCourses.map({$0.id})
                    
                    user.cartItems = try NSKeyedArchiver.archivedData(withRootObject: courseIds, requiringSecureCoding: true)
                } catch {
                    print("failed to archive array with error: \(error)")
                }
                saveToCoredata()
            }
        } label: {
            Text("Add to cart")
                .font(.title3)
                .bold()
        }
        .buttonStyle(.plain)
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 50, alignment: .center)
        .background(Color.green)
        .cornerRadius(16)
        .padding()
    }
    
    func saveToCoredata() {
        do {
            try moc.save()
            print("Updated Course changes to coredata")
        }
        catch {
            print("Error in updating the wishlist to coredata")
        }
    }
}

//struct CourseDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseDetailView(user: User(), pageType: .courses, course: mockCourses[0])
//    }
//}
