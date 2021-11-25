//
//  LoginView.swift
//  e-learning
//
//  Created by rvaidya on 22/11/21.
//

import SwiftUI
import CoreData

struct LoginView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @ObservedObject var viewModel = LoginViewModel()
    @ObservedObject var appNavState = AppState()
    
    @FetchRequest(entity: User.entity(), sortDescriptors: [], predicate: nil, animation: nil) var users: FetchedResults<User>


    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @State private var username = ""
    @State private var password = ""
    
    @State private var showUSNRules = false
    @State private var showPWDRules = false
    
    @FocusState private var didSubmitUSN: Bool

    @State private var goToDashboard = false
    let vmFactory = ViewModelFactory()
    
    @State private var user: User?
    
    var body: some View {
        NavigationView {
            VStack {
                logoView
                Spacer()
                    .frame(height: 100)
                loginMainView
                Spacer()
                NavigationLink(isActive: $goToDashboard) {
                    if user != nil {
                        HomeView(viewModel: vmFactory.getCoursesViewModel(), user: user!)
                            .environmentObject(appNavState)
                            .environment(\.managedObjectContext, managedObjectContext)
                    }
                  
                } label: {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                
                reset()
            }
        }
        .navigationViewStyle(.stack)

    }
    
    var logoView: some View {
        Image("hashedin-logo")
            .resizable()
            .scaledToFit()
            .frame(width: width * 0.7, height: height * 0.2, alignment: .center)

    }
    
    var loginMainView: some View {
        VStack(spacing: 20) {
            usernameView
            passwordView
            loginBtn
            createAcctBtnView

        }
        .frame(width: width*0.6, alignment: .center)

    }
    
    var usernameView: some View {
        VStack {
            HStack {
                TextField("Username", text: $username, prompt: Text("username"))
                    .onSubmit {
                        if !viewModel.isValid(usn: username) {
                            showUSNRules = true
                        }
                        didSubmitUSN = true
                    }
                    .onChange(of: username, perform: { newValue in
                        if showUSNRules {
                            showUSNRules = false
                        }
                        else if shouldLogin {
                            login()
                        }
                    })
                    .modifier(CustomTextField())
                
//                infoBtnView(isUsnView: true)
            }
            if showUSNRules {
                usernameInfoView
            }
        }
    }
    
    var passwordView: some View {
        VStack {
            HStack {
                TextField("Username", text: $password, prompt: Text("password"))
                    .modifier(CustomTextField())
                    .focused($didSubmitUSN)
                    .onChange(of: password) { newValue in
                        if !viewModel.isValid(usn: username) {
                            showUSNRules = true
                        }
                    }
                    .onSubmit {
                        if !viewModel.isValid(pwd: password) {
                            showPWDRules = true
                        }
                        else if shouldLogin {
                            login()
                        }
                    }
                
            }
            if showPWDRules {
                passwordInfoView
            }
        }
    }
    
    var loginBtn: some View {
        Button {
            if shouldLogin {
                showUSNRules = false
                showPWDRules = false
                login()
            }
            else if !viewModel.isValid(usn: username) {
                showUSNRules = true
            }
            else if !viewModel.isValid(pwd: password) {
                showPWDRules = true
            }
            
        } label: {
            Text("Login")
                .foregroundColor(.white)
                .padding()
                .frame(width: width*0.6, alignment: .center)
        }
        .buttonStyle(.plain)
        .background(Color.black)
        .cornerRadius(16)
    }
    
    var createAcctBtnView: some View {
        HStack {
            Spacer()
            Button {
                //
            } label: {
                Text("Create Account")
            }
//            .buttonStyle(.plain)
        }
       
    }
    
    var passwordInfoView: some View {
        Text("* Password must contain A-Z, a-z & a special character('@', '$', '*')")
            .font(.footnote)
            .foregroundColor(.red)
    }
    
    var usernameInfoView: some View {
        Text("* Username should be your mail id")
            .font(.footnote)
            .foregroundColor(.red)
    }
    
    func infoBtnView(isUsnView: Bool) -> some View {
        Button {
            if isUsnView {
                showUSNRules = true
            }
            else {
                showPWDRules = true
            }
        } label: {
            Image(systemName: "info.circle")
                .resizable()
                .frame(width: 20, height: 20, alignment: .center)
        }
        .buttonStyle(.plain)
    }
    
    var shouldLogin: Bool {
        viewModel.isValid(usn: username) && viewModel.isValid(pwd: password)
     }
    
    func login() {
        /* note: - This would be used in real case
            viewModel.login()
         */
        
        if users.isEmpty || !users.map({$0.username}).contains(username) {
            print("User doesnt exist. Create one")
            createNewUser()
        }
        else {
            
            users.forEach { user in
                if user.username == username {
                    self.user = user
                    goToDashboard = true
                    print("The Existing User \(user)")
                    print("User already exists. Navigate to Home.")
                    return
                }
            }
            
        }
        
    }
    
    func createNewUser() {
        let newUser = User(context: managedObjectContext)
        newUser.username = username
        newUser.password = password
        do {
            try managedObjectContext.save()
        } catch {
            // handle the Core Data error
            print("Error in saving to coredata")
        }
        self.user = newUser
        goToDashboard = true
        print("Created new user")
    }
    
    func reset() {
        username.removeAll()
        password.removeAll()
        showPWDRules = false
        showUSNRules = false
        appNavState.moveToDashboard = false
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

import Combine

class AppState: ObservableObject {
    @Published var moveToDashboard: Bool = false
}
