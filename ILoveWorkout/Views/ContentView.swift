//
//  ContentView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-01-23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CreateWorkoutView()
                .tabItem() {
                    Image(systemName: "doc.text.below.ecg.fill")
                    Text("Workout")
                }
                AccountView()
                .tabItem() {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Workout")
                }
                ProfileView()
                .tabItem() {
                    Image(systemName: "gearshape.fill")
                    Text("Workout")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
