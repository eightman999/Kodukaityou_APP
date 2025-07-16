import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        Form {
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .textContentType(.emailAddress)
            SecureField("Password", text: $password)
            Button("Sign Up") {
                // Placeholder for signup logic
            }
        }
        .navigationTitle("Sign Up")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { SignUpView() }
    }
}
