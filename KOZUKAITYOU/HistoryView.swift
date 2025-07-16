import SwiftUI

struct HistoryView: View {
    var body: some View {
        List {
            NavigationLink("Monthly Overview", destination: Text("Monthly Details"))
            NavigationLink("Yearly Overview", destination: Text("Yearly Details"))
        }
        .navigationTitle("History")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { HistoryView() }
    }
}
