import SwiftUI

struct ContentView: View {
    @State var entries: [Entry] = [] {
        didSet {
            if entries.count == 0 {
                screen = .entry
            }
        }
    }
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
                RunView(entries: $entries, screen: $screen)
        }
    }
}

#Preview {
    ContentView()
}
