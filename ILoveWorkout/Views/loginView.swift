import SwiftUI
import FirebaseAuth

struct loginView: View {
    
    
    @Binding var currentShowingView: String
    @AppStorage("uid") var userID: String = ""
    // State-variabler för att lagra e-post och lösenord
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Hello, & Welcome")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
                .padding()
                .padding(.top)
                
                Spacer()
                // Inmatningsfält för e-post
                HStack {
                    Image(systemName: "mail")
                    TextField("Email", text:$email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none) // Ernesto: tar bort auto korregerin av stor bokstav
                    
                    Spacer()
                    
                    if(email.count != 0) {
                        
                        Image(systemName: "checkmark")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    

                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                )
                .padding()
                
                // Inmatningsfält för lösenord
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text:$password)
                    
                    Spacer()
                    
                    if (password.count != 0) {
                        Image(systemName: "checkmark")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        }
                    
                    }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                )
                .padding()
                
                Button(action: {
                    withAnimation {
                        self.currentShowingView = "signup"
                    }

                }) {
                    Text("Don't have an account?")
                        .foregroundColor(.black.opacity(0.7))
                }
                
                Spacer()
                Spacer()
                
                Button {
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        if let authResult = authResult {
                            print(authResult.user.uid)
                            withAnimation {
                                userID = authResult.user.uid
                                    
                                
                            }
                        }
                    }
                    
                } label: {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                     
                        )
                        .padding(.horizontal)
                }

                
            }
        }.navigationBarBackButtonHidden(true)
    }
}



