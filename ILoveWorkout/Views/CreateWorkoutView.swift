//
//  CreateWorkoutView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-01-23.
//

import SwiftUI

struct CreateWorkoutView: View {
    var body: some View {
        ScrollView {
            VStack {
                DropDownView()
                Spacer()
                Button(action: {}) {
                    Text("Next")
                        .font(.system(size: 20, weight:
                                .medium))
                }
            }
            
        }
    }
}

