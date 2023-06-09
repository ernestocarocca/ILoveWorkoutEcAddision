import SwiftUI
import Firebase
import FirebaseAuth


struct FirstScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height:// Skapar ett tomt utrymme överst i vyen
                                    proxy.size.height * 0.40)
                    Text("Workout Diary")
                        .font(.system(size: 59, weight: .medium)) // Rubriktext med anpassad teckenstorlek och vikt
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink (destination: // En navigeringslänk till ContentView
                                   ContentView(), isActive:// Uppdaterar isActive-variabeln för att aktivera navigeringslänken
                                        $isActive) {
                        Button(action: {
                            isActive = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                Text("Continue")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }.padding()
                        }
                    }
                    // Anpassar vyns ramstorlek till att fylla hela skärmen
                }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .background(
                    Image("LoveWorkout")// Bakgrundsbild med namnet "LoveWorkout"
                        .resizable()
                        .aspectRatio(
                            contentMode: .fill
                        )
                        .edgesIgnoringSafeArea(.all)
                )
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreenView()
    }
}
