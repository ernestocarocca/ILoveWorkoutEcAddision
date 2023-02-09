//
//  ProfileView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-01-23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ProfileView: View {
    
    @State var logoutOptions = false

    var body: some View {
        VStack {
            
            TopNavigationBarView
            Spacer()
            Color.blue
        }
    }

    private var TopNavigationBarView: some View {
        
        HStack(spacing: 16) {
            
            Image(systemName: "person.fill")
                .font(.system(size: 64))
                .padding()
                .foregroundColor(Color(.label))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome")
                    .font(.system(size: 24, weight: .bold))
                
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("Online")
                        .font(.system(size: 15))
                        .foregroundColor(Color(.lightGray))
                }
            }
            
            Spacer()
            Button {
                logoutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
                Text("Logout")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.lightGray))
            }
        }
        .padding()
        .actionSheet(isPresented: $logoutOptions) {
            .init(title: Text("Alert"), message: Text("Do you want to logout?"), buttons: [
                .destructive(Text("Sign out"), action: {
                    print("Succes! You signed out")
                    try? Auth.auth().signOut()
                }),
                .cancel()
             ])
        }
    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
