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
                emptyCartView
            }
            else {
                coursesList
            }
            HStack {
                priceView
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
                backBtn
            }
        })
        .onAppear {
            viewModel.getTotalAmount()
            viewModel.getDiscountedBalance()
        }
    }
    
    var emptyCartView: some View {
        VStack {
            Spacer()
            Text("You have no cart items yet!")
            Spacer()
        }
    }
    
    var coursesList: some View {
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
    
    var priceView: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("Rs." + "\(viewModel.totalCartPrice.rounded(toPlaces: 2))" + "/-")
                .bold()
            Text("You saved Rs." + "\(viewModel.discountedDifference.rounded(toPlaces: 2))" + "/-")
                .foregroundColor(.red)
                .font(.footnote)
        }
        .padding(.leading)
    }
    
    var checkoutBtn: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Checkout")
                .colorInvert()
                .padding()
        }
        .background(viewModel.cartCourses.isEmpty ? Color.gray.opacity(0.2) :  Color.appGreen)
        .buttonStyle(.plain)
        .cornerRadius(12)
        .frame(width: UIScreen.main.bounds.width * 0.3)
        .padding(.vertical)
        
        .disabled(viewModel.cartCourses.isEmpty ? true : false)
    }
    
    var backBtn: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Courses")
            }
        }
        .buttonStyle(.plain)
        .foregroundColor(.indigo)
    }
    
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(user: User())
        
    }
}
