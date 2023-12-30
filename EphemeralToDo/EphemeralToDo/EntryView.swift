import SwiftUI

struct EntryView: View {
    @State private var thing: String = ""
    @State var entries: [Entry] = []
    @FocusState private var focused: Bool

    var body: some View {
        VStack {
            TextField("Some Thing", text: $thing)
              .padding()

              .onSubmit {
                  makeNewThing(from: thing)
                  thing = ""
                  focused = true
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
        print("MAKE NEW THING \(thing)")
        let entry = Entry(thing: thing)
        entries.append(entry)
    }
}

#Preview {
    let entries = ["greeble", "bork", "splunge"]
      .map(Entry.init)
    return EntryView(entries: entries)
}
