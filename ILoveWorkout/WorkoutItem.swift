//
//  WorkoutItem.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-02-06.
//

import Foundation
import FirebaseFirestoreSwift


struct WorkoutItem : Codable, Identifiable {
    
    
    @DocumentID var id : String?
    
    var name : String
    var exercise : String = ""
    var done : Bool = false

}

