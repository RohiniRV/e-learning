//
//  ProfileView.swift
//  e-learning
//
//  Created by rvaidya on 23/11/21.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.managedObjectContext) var moc

    @State private var editingEnabled = false
    @State private var nametext = ""
    @State private var skillsText = ""
    @State private var bandName = ""
    @State private var level = ""
    @State private var bio = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    @State private var profileImage: Image? = nil
    var user: User

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                navBarView
                Divider()
                profileImageView
                Spacer()
                detailsView
                Spacer()
                logoutBtnStack
                Spacer()
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
            .onAppear(perform: {
                statePropertiesInitialization()
            })
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
        .navigationViewStyle(.stack)
       
    }
    
    var navBarView: some View {
        HStack {
            Text("Profile")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.indigo)
                .padding()
            Spacer()
            editIconView
        }
    }
    
    var editIconView: some View {
        Button {
            saveProfileData()
        } label: {
            if editingEnabled {
                Text("Done")
                    .colorInvert()
                    .padding(10)
            }
            else {
                Image(systemName: "pencil.circle")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(10)
            }
        }
        .buttonStyle(.plain)
        .background(editingEnabled ? Color.indigo : .clear)
        .cornerRadius(12)
    }
    
    var profileImageView: some View {
        HStack {
            Spacer()
            Button {
                showingImagePicker.toggle()
            } label: {
                if profileImage == nil {
                    defaultPhotoView
                }
                else {
                    photoView
                }
            }
            .frame(width: 150, height: 150, alignment: .center)
            Spacer()
        }
      
    }
    
    var defaultPhotoView: some View {
        Image(systemName: "photo.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
    }
    
    var photoView: some View {
        profileImage!
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
    
    var detailsView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 20) {
                    cellView(type: .name, bindingValue: $nametext, value: nametext)
                    cellView(type: .bandName, bindingValue: $bandName, value: bandName)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    cellView(type: .skills, bindingValue: $skillsText, value: skillsText)
                    cellView(type: .level, bindingValue: $level, value: level)
                }
            }
            VStack(alignment: .leading) {
                cellView(type: .bio, bindingValue: $bio, value: bio)
            }
        }
    }
    
    func cellView(type: cellType, bindingValue: Binding<String>, value: String) -> some View {
        HStack{
        VStack(alignment: .leading, spacing: 5) {
            Text(type.rawValue)
                .foregroundColor(.gray)
            if editingEnabled {
                TextField("", text: bindingValue, prompt: Text(value))
                    .modifier(CustomTextField())
            }
            else {
                Text(value)
                    .foregroundColor(.indigo)
            }
        }
        .padding(.leading)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width * 0.5)
    }
    
    var logoutBtnStack: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    appState.moveToDashboard = true
                } label: {
                    Text("Logout")
                        .fontWeight(.semibold)
                        .colorInvert()
                }
                .buttonStyle(.plain)
                .padding()
                .background(Color.appGreen)
                .cornerRadius(12)
                Spacer()
            }
           Text("Version 1.0")
                .fontWeight(.semibold)
        }
    }
    
    func saveProfileData() {
        editingEnabled.toggle()
        user.name = nametext
        user.bio = bio
        user.level = level
        user.skills = skillsText
        user.bandName = bandName
        do {
            try moc.save()
            print("Saved profile name to coredata")
        }
        catch(let err) {
            print("\(err.localizedDescription)")
        }
    }
    
    func statePropertiesInitialization() {
        nametext = user.profileName
        bio = user.userBio
        level = user.userLevel
        skillsText = user.userSkills
        bandName = user.userBandName
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User())
    }
}
