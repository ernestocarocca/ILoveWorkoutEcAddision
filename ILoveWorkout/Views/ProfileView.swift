import SwiftUI
import Firebase
import FirebaseAuth
import Charts

struct ProfileView: View {
    // Användar-ID som lagras i AppStorage
    @AppStorage("uid") var userID: String = "" //Ernesto ändrat
    @State var logoutOptions = false
    @State private var userIsLoggedIn = false
    //Ernesto ändrat namn från CurrentImageIndex
    @State private var currentImageIndex = 0 // Index för att hålla reda på aktuell bild i bildspelet
    
    
    private var numberOfImages = 6
    private let timer = Timer.publish(every: 2, on: .main, in: .common
    ).autoconnect()
    
    var body: some View {
        VStack {
            TopNavigationBarView
            Spacer()
            BarChartsView() // Visa stapeldiagram
            
            GeometryReader { proxy in
                TabView(selection: $currentImageIndex) {
                    ForEach(0..<numberOfImages) { num in
                        Image("\(num)")
                            .resizable()
                            .scaledToFill()
                            .overlay(Color.black.opacity(0.4))
                            .tag(num)
                    }
                }.tabViewStyle(PageTabViewStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding()
                    .frame(width: proxy.size.width, height:
                            proxy.size.height / 1)
               // Byt till nästa bild med hjälp av timer
                    .onReceive(timer, perform: { _ in
                        next()
                        
                        })
                
            }
            controls // Visa kontroller för att navigera mellan bilderna
            Spacer()
            Spacer()
            
        }
        
    }
    
    func previous() {
        withAnimation {
            currentImageIndex = currentImageIndex > 0 ? currentImageIndex
            - 1 : numberOfImages  - 1
        }
    }

    func next() {
        withAnimation {
            currentImageIndex = currentImageIndex <
                numberOfImages ? currentImageIndex + 1 : 0
            }
        }
    
    var controls: some View {
        HStack {
            Button {
                previous()
            } label: {
                Image(systemName: "chevron.left")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            Button {
                next()
            } label: {
                Image(systemName: "chevron.right")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
            }
        }
    }
    
    private var TopNavigationBarView: some View {
        HStack(spacing: 16) {
            
            Image(systemName: "person.fill")
                .font(.system(size: 64))
                .padding()
                .foregroundColor(Color(.label))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome")
                    .font(.system(size: 24, weight: .bold))
                
                    HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("Online")
                        .font(.system(size: 15))
                        .foregroundColor(Color(.lightGray))
                }
            }
            
            Spacer()
            Button {
                logoutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
                Text("Logout")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.lightGray))
            }
        }
        .padding()
        .actionSheet(isPresented: $logoutOptions) {
            .init(title: Text("Alert"), message: Text("Do you want to logout?"), buttons: [
                .destructive(Text("Sign out"), action: {
                    print("Succes! You signed out")
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                        withAnimation {
                            userID = ""
                        }
                    } catch let signOutError as NSError {
                        print("Error signing out: #€", signOutError)
                    }
                    
                 
                }),
                .cancel()
             ])
        }

    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

