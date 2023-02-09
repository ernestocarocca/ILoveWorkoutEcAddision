//
//  ButtonView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-02-09.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

struct ButtonView: View {
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    
    
    @State var content : String = ""
    
    
    
    
    
    var body: some View {
        VStack{
            TextEditor(text: $content)
        }
        .navigationBarItems(trailing: Button("Save") {
            saveExercise(workoutName: content)
        })
    }
    
    func saveExercise(workoutName: String) {
        if let currentUser {
                db.collection("users").document(currentUser.uid).collection("exercises").addDocument(data:
                                                                                                        ["name" : workoutName,
                                                                                                         "exercise" : "",
                                                                                                         "done": false])
            }

        }
        
    
}
