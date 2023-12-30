import SwiftUI

struct ContentView: View {
    @State var entries: [Entry] = []
    @State var screen: Screen = .entry

    enum Screen {
        case entry
        case run
    }

    var body: some View {
        switch screen {
            case .entry: 
                VStack {
                    HStack {
                        Spacer()
                        Button("Done") {
                            print("Splunge")
                            screen = .run
                        }.padding([.trailing])
                    }
                    EntryView(entries: $entries)
                }
            case .run:
                RunView()
        }
    }
}

#Preview {
    ContentView()
}
