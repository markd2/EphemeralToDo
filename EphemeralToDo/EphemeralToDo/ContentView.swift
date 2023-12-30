import SwiftUI

struct ContentView: View {
    @State var entries: [Entry] = []

    var body: some View {
        EntryView(entries: $entries)
    }
}

#Preview {
    ContentView()
}
