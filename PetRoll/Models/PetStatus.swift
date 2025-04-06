import Foundation

struct PetStatus {
    var knowledge: Double
    var hunger: Double
    var health: Double {
        return (knowledge + hunger) / 2.0
    }
}
