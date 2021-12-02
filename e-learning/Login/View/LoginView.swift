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
    @State private var showLoggingAnimation = false

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
                        HomeView(viewModel: vmFactory.getCoursesViewModel(for: user!), user: user!)
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
            .onReceive(appNavState.$moveToDashboard) { value in
                if value {
                    appNavState.moveToDashboard = false
                }
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
//            createAcctBtnView
        }
        .frame(width: width*0.6, alignment: .center)

    }
    
    var usernameView: some View {
        VStack {
            HStack {
                TextField("Username", text: $username, prompt: Text("Username"))
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
            }
            if showUSNRules {
                usernameInfoView
            }
        }
    }
    
    var passwordView: some View {
        VStack {
            HStack {
                SecureField("Password", text: $password, prompt: Text("Password"))
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
            if showLoggingAnimation {
                ProgressView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                            if showLoggingAnimation {
                                goToDashboard = true
                            }
                        })
                    }
                    .padding(.leading)
            }
            Text(showLoggingAnimation ? "Logging you in..." : "Login")
                .fontWeight(.semibold)
                .colorInvert()
                .padding()
        }
        .buttonStyle(.plain)
        .background(Color.indigo)
        .cornerRadius(16)
        .frame(width: width*0.6, alignment: .center)

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
        Text("* Password must contain A-Z, a-z & a special character('@', '$', '*') & should be atleast 8 characters.")
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
        print("Logging you in...")
        if users.isEmpty || !users.map({$0.username}).contains(username) {
            createNewUser()
        }
        else {
            users.forEach { user in
                if user.username == username {
                    self.user = user
                    showLoggingAnimation = true
                    print("Verified the user as existing user...")
                    return
                }
            }
            
        }
        
    }
    
    func createNewUser() {
        print("Creating a new user while trying to login...")
        
        let newUser = User(context: managedObjectContext)
        newUser.username = username
        newUser.password = password
        do {
            try managedObjectContext.save()
        } catch(let err) {
            // handle the Core Data error
            print("\(err.localizedDescription)")
        }
        self.user = newUser
//        goToDashboard = true
        showLoggingAnimation = true
    }
    
    func reset() {
        username.removeAll()
        password.removeAll()
        showPWDRules = false
        showUSNRules = false
        showLoggingAnimation = false
        goToDashboard = false
        appNavState.moveToDashboard = false
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
