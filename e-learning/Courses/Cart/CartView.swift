//
//  CartView.swift
//  e-learning
//
//  Created by rvaidya on 23/11/21.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var viewModel: CoursesViewModel
    @Environment(\.presentationMode) var presentationMode

    var user: User
    
    var body: some View {
        VStack {
            if viewModel.cartCourses.isEmpty {
                Spacer()
                Text("You have no cart items yet!")
                Spacer()
            }
            else {
                if !viewModel.cartCourses.isEmpty {
                    List(viewModel.cartCourses, id: \.id) { course in
                        NavigationLink {
                            CourseDetailView(user: user, pageType: .cart, course: course)
                                .environmentObject(viewModel)
                            
                        } label: {
                            courseRow(course: course)
                        }
                        .buttonStyle(.plain)
                    }
                    .listStyle(.plain)
                }
                else {
                    List(user.cartCourses, id: \.id) { course in
                        NavigationLink {
                            CourseDetailView(user: user, pageType: .cart, course: course)
                                .environmentObject(viewModel)
                            
                        } label: {
                            courseRow(course: course)
                        }
                        .buttonStyle(.plain)
                    }
                    .listStyle(.plain)
                }
                
            }
           
            HStack {
                VStack(alignment: .leading, spacing: 5){
                    Text("Rs." + "\(viewModel.totalCartPrice.rounded(toPlaces: 2))" + "/-")
                        .bold()
                    Text("You saved Rs." + "\(viewModel.discountedDifference.rounded(toPlaces: 2))" + "/-")
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                .padding(.leading)
                Spacer()
                
                checkoutBtn
            }
            .background(Color.gray.opacity(0.2))
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(Text("Cart"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Courses")

                    }
                }

            }
        })
        .onAppear {
//            viewModel.getCoursesInCart(user: user)
            viewModel.getTotalAmount()
            viewModel.getDiscountedBalance()
        }
    }
    
    var checkoutBtn: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Checkout")
                .padding()
            
        }
        .background(viewModel.cartCourses.isEmpty ? Color.gray.opacity(0.2) :  Color.green)
        .buttonStyle(.plain)
        .cornerRadius(12)
        .frame(width: UIScreen.main.bounds.width * 0.3)
        .padding(.vertical)
        
        .disabled(viewModel.cartCourses.isEmpty ? true : false)
    }
    
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(user: User())
        
    }
}
