import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Home Screen")
                    .font(.largeTitle)
                    .padding()
                NavigationLink("View History", destination: HistoryView())
                NavigationLink("Settings", destination: SettingsView())
            }
            .navigationTitle("Kodukaityou")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
