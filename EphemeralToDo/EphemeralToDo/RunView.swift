import SwiftUI

struct RunView: View {
    @Binding var entries: [Entry]
    @Binding var screen: ContentView.Screen

    @State var entry: Entry?

    func moveToEntryScreen() {
        screen = .entry
    }

    var body: some View {
        VStack {
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
                        ContentView.saveToUserDefaults(entries)
                        if entries.isEmpty {
                            moveToEntryScreen()
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
}

#Preview {
    @State var entries = ["greeble", "bork", "splunge"]
      .map(Entry.init)
    @State var screen = ContentView.Screen.run
    return RunView(entries: $entries, screen: $screen)
}
