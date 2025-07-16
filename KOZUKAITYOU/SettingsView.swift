import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            NavigationLink("Login", destination: LoginView())
            NavigationLink("Sign Up", destination: SignUpView())
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { SettingsView() }
    }
}
