//
//  DropDownView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-01-23.
//

import SwiftUI

struct DropDownView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Exercise")
                    .font(.system(size: 23, weight: .semibold))
            Spacer()
            }.padding(.vertical, 15)
            Button(action: {}) {
                HStack {
                    Text("Situps")
                        .font(.system(size: 23, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))
                }
            }.buttonStyle(MyButtonStyle(fillColor:
                    .ButtonColor))
            
            Button(action: {}) {
                HStack {
                    Text("Exercise Amount")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))
                    
                }
            }.buttonStyle(MyButtonStyle(fillColor:
                    .ButtonColor))
            
            HStack {
                Text("Exercise")
                    .font(.system(size: 23, weight: .semibold))
                Spacer()
            }.padding(.vertical, 10)
            
            Button(action: {}) {
                HStack {
                    Text("Pushups")
                        .font(.system(size: 23, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))
                    
                }
            }.buttonStyle(MyButtonStyle(fillColor:
                    .ButtonColor))
            
            Button(action: {}) {
                HStack {
                    Text("Exercise Amount")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))
                    
                }
            }.buttonStyle(MyButtonStyle(fillColor:
                    .ButtonColor))
            
            HStack {
                Text("Exercise")
                    .font(.system(size: 23, weight: .semibold))
                Spacer()
            }.padding(.vertical, 10)
            
            Button(action: {}) {
                HStack {
                    Text("Squats")
                        .font(.system(size: 23, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))
                    
                }
            }.buttonStyle(MyButtonStyle(fillColor:
                    .ButtonColor))
            
            Button(action: {}) {
                HStack {
                    Text("Exercise Amount")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))
                    
                }
            }.buttonStyle(MyButtonStyle(fillColor:
                    .ButtonColor))
            
            
            
        }.padding(15)
    }
    
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DropDownView().environment(\.colorScheme, .light)
        }
        
        NavigationView {
            DropDownView().environment(\.colorScheme, .dark)
        }
    }
}
