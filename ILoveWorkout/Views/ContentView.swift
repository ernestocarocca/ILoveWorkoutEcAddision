//
//  ContentView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-01-23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        TabView {
            WorkoutView()
                .tabItem() {
                    Image(systemName: "doc.text.below.ecg.fill")
                    Text("Workout")
                }
                AccountView()
                .tabItem() {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Account")
                }
                ProfileView()
                .tabItem() {
                    Image(systemName: "gearshape.fill")
                    Text("Profile")
                }
        }
        .navigationBarBackButtonHidden(false)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
