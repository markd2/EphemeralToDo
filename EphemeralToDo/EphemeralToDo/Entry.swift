import Foundation

struct Entry: Identifiable {
    let thing: String
    let id: UUID = UUID()
}
