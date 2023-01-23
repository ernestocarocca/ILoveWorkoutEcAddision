//
//  ContentView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-01-23.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer().frame(height:
                                proxy.size.height * 0.40)
                Text("I Love Workout")
                    .font(.system(size: 59, weight: .medium))
                    .foregroundColor(.white)
                Spacer()
                Button(action: {}) {
                    HStack {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        Text("Create Workout")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }.padding()
                }
            }.frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(
                Image("LoveWorkout")
                    .resizable()
                    .aspectRatio(
                        contentMode: .fill
                    )
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
