import SwiftUI

struct EntryView: View {
    @Binding var entries: [Entry]

    @State private var thing: String = ""
    @FocusState private var focused: Bool

    var body: some View {
        VStack {
            TextField("Some Thing", text: $thing)
              .padding()

              .onSubmit {
                  focused = true
                  makeNewThing(from: thing)
                  thing = ""
              }
            .focused($focused)
              .textInputAutocapitalization(.never)
              .disableAutocorrection(true)
              .border(.secondary)
            List(entries) { entry in
                Text(entry.thing)
            }
            .listStyle(.plain)
        }
          .padding()
        .onAppear {
            focused = true
        }
    }

    func makeNewThing(from thing: String) {
        let entry = Entry(thing)
        entries.append(entry)
        ContentView.saveToUserDefaults(entries)
    }
}

#Preview {
    @State var entries = ["greeble", "bork", "splunge"]
      .map(Entry.init)
    return EntryView(entries: $entries)
}
