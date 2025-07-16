import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        Form {
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .textContentType(.emailAddress)
            SecureField("Password", text: $password)
            Button("Login") {
                // Placeholder for login logic
            }
        }
        .navigationTitle("Login")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { LoginView() }
    }
}
