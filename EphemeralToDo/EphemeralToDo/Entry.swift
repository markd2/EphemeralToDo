import Foundation

struct Entry: Identifiable, Codable {
    let thing: String
    let id: UUID
    
    init(_ thing: String) {
        self.thing = thing
        id = UUID()
    }
}
