//
//  WorkoutViewModel.swift
//  ILoveWorkout
//
//  Created by Ernesto Carocca on 2023-06-08.
//
import Firebase
import FirebaseAuth
import SwiftUI
import Foundation
class WorkoutViewModel: ObservableObject {
    @Published var workoutItems = [WorkoutItem]()
    let db = Firestore.firestore()
    
    func listenToFirestore(for currentUser: User?) {
        if let currentUser = currentUser {
            db.collection("users").document(currentUser.uid).collection("exercises").addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else { return }
                
                if let error = error {
                    print("Error getting document: \(error)")
                } else {
                    self.workoutItems.removeAll()
                    for document in snapshot.documents {
                        if let workoutItem = try? document.data(as: WorkoutItem.self) {
                            self.workoutItems.append(workoutItem)
                        }
                    }
                }
            }
        }
    }
    
    // ändra statusen (klar/inte klar) för en träningsövning
    func toggleCompletion(for workoutItem: WorkoutItem) {
        if let currentUser = Auth.auth().currentUser,// Kontrollerar om det finns en inloggad användare
           let documentID = workoutItem.id {  // Hämtar ID för den specifika träningsövningen
            let isDone = !workoutItem.done // Inverterar statusen för att ändra från klart till inte klart, eller tvärtom
            db.collection("users").document(currentUser.uid).collection("exercises").document(documentID).updateData(["done": isDone])
            // Uppdaterar statusen för träningsövningen i Firestore-databasen
        }
    }
    //Denna funktion används för att ta bort träningsobjekt från Firebase-databasen
    func deleteItems(at indices: IndexSet) {
        for index in indices {
            let workoutItem = workoutItems[index]
            if let documentID = workoutItem.id,
               let currentUser = Auth.auth().currentUser {
                db.collection("users").document(currentUser.uid).collection("exercises").document(documentID).delete()
            }
        }
    }
    
}

