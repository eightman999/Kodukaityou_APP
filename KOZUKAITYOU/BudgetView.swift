import SwiftUI

struct BudgetView: View {
    var body: some View {
        Text("Budget Settings")
            .padding()
            .navigationTitle("Budget")
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { BudgetView() }
    }
}
