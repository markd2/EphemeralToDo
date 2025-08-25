import SwiftUI

struct ContentView: View {
    @State var entries: [Entry] {
        didSet {
            ContentView.saveToUserDefaults(entries)
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
    
    static func saveToUserDefaults(_ entries: [Entry]) {
        let data = try! JSONEncoder().encode(entries)
        UserDefaults.standard.set(data, forKey: "EntriesJSON")
        UserDefaults.standard.synchronize()
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: "EntriesJSON"),
           let entries = try? JSONDecoder().decode([Entry].self, from: data) {
            self.entries = entries;
        } else {
            self.entries = []
        }
    }
    
    func displayName() -> String {
        // if we can't get the display name, then everything is screwed, so ok to die.
        let bundleDisplayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
        return bundleDisplayName
    }
    
    var body: some View {
        switch screen {
        case .entry: 
            VStack {
                HStack {
                    Spacer()
                    Text(displayName()).bold()
                    Spacer()
                    Button("Roll!") {
                        screen = .run
                    }.padding([.trailing])
                }
                EntryView(entries: $entries)
            }
        case .run:
            VStack {
                HStack {
                    Spacer()
                    Button("Edit Entries") {
                        screen = .entry
                    }.padding([.trailing])
                }
                Spacer()
                RunView(entries: $entries, screen: $screen)
                Spacer()

            }
        }
    }
}

#Preview {
    ContentView()
}
