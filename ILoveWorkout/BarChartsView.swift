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


struct BarChartsView: View {
    
    //Mockdata
    let workoutMonths: [WorkoutMonth] = [
        .init(date: Date.from(year: 2023, month: 1, day: 1), workoutCount: 20),
        .init(date: Date.from(year: 2023, month: 2, day: 1), workoutCount: 75),
        .init(date: Date.from(year: 2023, month: 3, day: 1), workoutCount: 69),
        .init(date: Date.from(year: 2023, month: 4, day: 1), workoutCount: 55),
        .init(date: Date.from(year: 2023, month: 5, day: 1), workoutCount: 110),
        .init(date: Date.from(year: 2023, month: 6, day: 1), workoutCount: 105),
        .init(date: Date.from(year: 2023, month: 7, day: 1), workoutCount: 200),
        .init(date: Date.from(year: 2023, month: 8, day: 1), workoutCount: 155),
        .init(date: Date.from(year: 2023, month: 9, day: 1), workoutCount: 170),
        .init(date: Date.from(year: 2023, month: 10, day: 1), workoutCount: 38),
        .init(date: Date.from(year: 2023, month: 11, day: 1), workoutCount: 98),
        .init(date: Date.from(year: 2023, month: 12, day: 1), workoutCount: 300)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Exercises Counter")

            Text("Total: \(workoutMonths.reduce(0, { $0 + $1.workoutCount }))")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)

            Chart {
                RuleMark(y: .value("Goal", 200))
                    .foregroundStyle(Color.black)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))

                ForEach(workoutMonths) { workoutMonth in
                    BarMark(
                        x: .value("Month", workoutMonth.date, unit: .month),
                        y: .value("WorkoutCount", workoutMonth.workoutCount)
                    )
                    .foregroundStyle(Color.pink.gradient)
                    .cornerRadius(10)
                }
            }
            .frame(height: 180)
            .chartYScale()
            .chartYAxis {
                AxisMarks(values: workoutCount.map {$0.workoutCount}) { count in
                    AxisValueLabel(format: .count.month(.narrow))
                }
            }
            .chartXAxis {
                AxisMarks(values: workoutMonths.map {$0.date}) { date in
                    AxisValueLabel(format:
                                    .dateTime.month(.narrow),
                                     centered: true)
                }
            }
            .chartXAxis {
                AxisMarks { mark in
                    AxisValueLabel()
                    AxisGridLine()
                }
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

struct BarChartsView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartsView()
    }
}

//flytta kanske till workoutitem?
struct WorkoutMonth: Identifiable {
    let id = UUID()
    let date: Date
    let workoutCount: Int
}


extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}
