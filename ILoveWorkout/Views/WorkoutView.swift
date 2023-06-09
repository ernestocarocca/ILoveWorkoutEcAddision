import SwiftUI
import Firebase
import FirebaseAuth


struct WorkoutView: View {
    //@AppStorage("uid") var userID: String = ""
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
   
    @StateObject private var viewModel = WorkoutViewModel()
    @State private var logoutOptions = false

    var body: some View {
        NavigationView {
            VStack {
                List { // Skapar en rad för varje workoutItem i viewModel.workoutItems
                    ForEach(viewModel.workoutItems) { workoutItem in
                        WorkoutItemRow(workoutItem: workoutItem, toggleCompletion: { viewModel.toggleCompletion(for: workoutItem) })
                    }
                    .onDelete { indexSet in
                        viewModel.deleteItems(at: indexSet)
                    }
                }
            }
            .navigationBarTitle("Exercise List")
            .navigationBarItems(trailing:
                NavigationLink(destination: ButtonView()) {
                    Image(systemName: "plus.circle")
                        .transition(.move(edge: .bottom))
                }
            )
            .onAppear {
                viewModel.listenToFirestore(for: currentUser)
            }
            .padding()
        }
    }
}
// presenterar en enskild rad över träningsövningar
struct WorkoutItemRow: View {
    let workoutItem: WorkoutItem
    let toggleCompletion: () -> Void
    
    var body: some View {
        HStack {
            Text(workoutItem.name)
            Spacer()
            Button(action: toggleCompletion) {
                Image(systemName: workoutItem.done ? "checkmark.square" : "square")
            }
        }
    }
}

