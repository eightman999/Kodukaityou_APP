import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            NavigationView {
                AddEntryView()
            }
            .tabItem {
                Label("Add", systemImage: "plus.circle")
            }
            NavigationView {
                BudgetView()
            }
            .tabItem {
                Label("Budget", systemImage: "chart.bar")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
