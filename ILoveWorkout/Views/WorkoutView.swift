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
    
   
    @State var newWorkout : String = ""
    @State var workoutitems = [WorkoutItem]()
    
    
    
//    var searchBar : some View {
//        HStack {
//            TextField("Enter in a new workout", text:
//                        self.$newWorkout)
//            Button(action: self.addNewWorkout, label: {
//                    Text("Add New")
//            })
//        }
//    }

    
    var body: some View {
        NavigationView {
            VStack() {
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
            }.navigationBarTitle("Exercise")
             .onAppear() {
//                saveToFirestore(workoutName: "Situps 25 st")
//                 saveToFirestore(workoutName: "Pushups 25 st - 25kg viktplatta")
//                 saveToFirestore(workoutName: "Squats 25 st - 100kg")
                listenToFirestore()
            }
            .padding()
        }
}
  
    
    func saveToFirestore(workoutName: String) {
        
        
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
