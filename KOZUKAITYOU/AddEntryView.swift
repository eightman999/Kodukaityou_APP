import SwiftUI

struct AddEntryView: View {
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var amount: String = ""

    var body: some View {
        Form {
            Section(header: Text("Entry")) {
                TextField("Name", text: $name)
                TextField("Quantity", text: $quantity)
                    .keyboardType(.numberPad)
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            Button("Save") {
                // Placeholder for save logic
            }
        }
        .navigationTitle("Add Item")
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { AddEntryView() }
    }
}
