//
//  FirestoreProvider.swift
//  ILoveWorkout
//
//  Created by Ernesto Carocca on 2023-06-07.
//
import SwiftUI
import Firebase
import FirebaseAuth
import Foundation
// Exempel på en klass som ansvarar för att skapa och hantera en instans av Firestore
import Firebase

class FirestoreProvider {
    let db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    func listenToFirestore(currentUser: User?, completion: @escaping ([WorkoutItem]?, Error?) -> Void) {
        guard let currentUser = currentUser else {
            completion(nil, nil)
            return
        }
        
        db.collection("users").document(currentUser.uid).collection("exercises").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                completion(nil, error)
                return
            }
            
            var workoutItems = [WorkoutItem]()
            
            for document in snapshot.documents {
                let result = Result {
                    try document.data(as: WorkoutItem.self)
                }
                
                switch result {
                case .success(let workoutItem):
                workoutItems.append(workoutItem)
                    
                case .failure(let error):
                    print("Error decoding workout item: \(error)")
                }
            }
            
            completion(workoutItems, nil)
        }
    }
    
    func updateWorkoutItem(currentUser: User?, workoutItem: WorkoutItem, completion: @escaping (Error?) -> Void) {
        guard let currentUser = currentUser,
              let documentID = workoutItem.id else {
            completion(nil)
            return
        }
        
        let data: [String: Any] = [
            "name": workoutItem.name,
            "done": workoutItem.done
        ]
        
        db.collection("users").document(currentUser.uid).collection("exercises").document(documentID).setData(data, merge: true) { error in
            completion(error)
        }
    }
    
    func deleteWorkoutItem(currentUser: User?, workoutItem: WorkoutItem, completion: @escaping (Error?) -> Void) {
        guard let currentUser = currentUser,
              let documentID = workoutItem.id else {
            completion(nil)
            return
        }
        
        db.collection("users").document(currentUser.uid).collection("exercises").document(documentID).delete { error in
            completion(error)
        }
    }
}
