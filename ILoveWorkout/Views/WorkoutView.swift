//
//  WorkoutView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-02-06.
//

import SwiftUI
import Firebase

struct WorkoutView: View {
    let db = Firestore.firestore()
    
    @State var workoutitems = [WorkoutItem]()
    
    var body: some View {
    
            VStack {
                List {
                    ForEach(workoutitems) {workoutitems in
                        HStack {
                            Text(workoutitems.name)
                            Spacer()
                            Button(action: {
                                if let id = workoutitems.id {
                                    db.collection("workoutitems").document(id).updateData(["done": !workoutitems.done])
                                }
                            }) {
                                Image(systemName: workoutitems.done ? "checkmark.square" : "square")
                            }
                            
                        }
                    }.onDelete() { indexSet in
                        for index in indexSet {
                            let workoutitem = workoutitems[index]
                            if let id = workoutitem.id {
                                db.collection("workoutitems").document(id).delete()
                            }
                        }
                        
                    }
                }
            }.onAppear() {
                
                listenToFirestore()
            }
            .padding()
    }
    
    
    func saveToFirestore(workoutName: String) {
        //let workoutitem = WorkoutItem(name: workoutName)
        
        db.collection("workoutitems").addDocument(data: ["name" : workoutName,
                                                         "exercise" : "",
                                                         "done": false])
    }
    func listenToFirestore() {
            db.collection("workoutitems").addSnapshotListener { snapshot, err in
                guard let snapshot = snapshot else {return}
                
                if let err = err {
                    print("Error getting document \(err)")
                } else {
                    workoutitems.removeAll()
                    for document in snapshot.documents {

                        let result = Result {
                            try document.data(as: WorkoutItem.self)
                        }
                        switch result  {
                        case .success(let workoutitem)  :
                            workoutitems.append(workoutitem)
                        case .failure(let error) :
                            print("Error decoding workoutitem: \(error)")
                        }
                    }
                }
            }
        }
    }
        


struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
