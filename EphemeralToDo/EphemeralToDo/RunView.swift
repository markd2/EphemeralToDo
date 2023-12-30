import SwiftUI

struct RunView: View {
    // not a binding, since it's ephemeral
    @State var entries: [Entry]
    @State var entry: Entry?

    var body: some View {
        if let entry {
            Text(entry.thing)
              .font(.largeTitle)
            .padding([.bottom], 50.0)

            HStack {
                Button("Done") {
                    self.entry = nil
                    entries.removeAll { thing in
                        thing.id == entry.id
                    }
                }
                Spacer()
                Button("Done/Keep") {
                    self.entry = nil
                }
            }.padding([.leading, .trailing], 50.0)

        } else {
            Button("Roll!") {
                entry = entries.randomElement()
            }
        }
    }
}

#Preview {
    let entries = ["greeble", "bork", "splunge"]
      .map(Entry.init)
    return RunView(entries: entries)
}
