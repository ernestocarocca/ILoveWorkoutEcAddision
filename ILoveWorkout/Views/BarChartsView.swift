//
//  BarChartsView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-02-16.
//

import SwiftUI
import Charts
import Firebase
import FirebaseAuth
import Foundation

// Ernesto: visar en Diagram på träning och resulat
struct BarChartsView: View {
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    
    @StateObject private var viewModel = WorkoutViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Exercises Counter")
            
            Text("Total: \(viewModel.workoutItems.reduce(0, { $0 + $1.workoutCount }))")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            
            Chart {
                RuleMark(y: .value("Goal", 200))
                    .foregroundStyle(Color.black)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                
                ForEach(viewModel.workoutItems) { workoutItem in
                    BarMark(
                        x: .value("Month", workoutItem.date, unit: .month),
                        y: .value("WorkoutCount", workoutItem.workoutCount)
                    )
                    .foregroundStyle(Color.red.gradient)
                    .cornerRadius(10)
                }
            }
            .frame(height: 180)
            .chartYScale()
            
            .chartXAxis {
                AxisMarks(values: viewModel.workoutItems.map { $0.date }) { date in
                    AxisValueLabel(format: .dateTime.month(.narrow), centered: true)
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            
            HStack {
                Image(systemName: "line.diagonal")
                    .rotationEffect(Angle(degrees: 45))
                    .foregroundColor(.black)
                
                Text("Monthly Goal")
                    .foregroundColor(.secondary)
            }
            .font(.caption2)
            .padding(.leading, 4)
        }
        .padding()
    }
}

//     Ernesto: ska flyttas ut till WorkoutViewModel

    


//struct BarChartsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BarChartsView(workoutitems: <#[WorkoutItem]#>)
//    }
//}

extension Date {
    static func from(month: Int) -> Date {
        let components = DateComponents(month: month)
        return Calendar.current.date(from: components)!
    }
}
