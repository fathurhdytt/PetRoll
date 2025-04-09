import Foundation
import Combine

class PetViewModel: ObservableObject {
    @Published private(set) var petStatus: PetStatus

    private var timer: Timer?
    private let decayRate = 0.01 / 60.0 // 1% per menit

    private let knowledgeKey = "knowledgePet"
    private let hungerKey = "hungerPet"
    private let lastActiveKey = "lastActivePet"
    private let hintCountKey = "hintCountKey"

    init() {
        let savedKnowledge = UserDefaults.standard.double(forKey: knowledgeKey)
        let savedHunger = UserDefaults.standard.double(forKey: hungerKey)
        let lastActive = UserDefaults.standard.double(forKey: lastActiveKey)
        let savedHint = UserDefaults.standard.integer(forKey: hintCountKey)
        
        let currentTime = Date().timeIntervalSince1970
        let elapsedTime = currentTime - lastActive
        let decayAmount = elapsedTime * decayRate

        let knowledge = max(savedKnowledge - decayAmount, 0.0)
        let hunger = max(savedHunger - decayAmount, 0.0)
        let hint = UserDefaults.standard.object(forKey: hintCountKey) as? Int ?? 3


        petStatus = PetStatus(knowledge: knowledge, hunger: hunger, hint: hint)

        startTimer()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.decayStats()
        }
    }

    private func decayStats() {
        let newKnowledge = max(petStatus.knowledge - 0.01, 0.0)
        let newHunger = max(petStatus.hunger - 0.01, 0.0)
        
        petStatus = PetStatus(
            knowledge: newKnowledge,
            hunger: newHunger,
            hint: petStatus.hint
        )
        
        saveStatus()
    }


    func feed(isLocated: Bool) {
        let increaseAmount = isLocated ? 0.10 : 0.05
        let newHunger = min(petStatus.hunger + increaseAmount, 1.0)
        
        petStatus = PetStatus(
            knowledge: petStatus.knowledge,
            hunger: newHunger,
            hint: petStatus.hint
        )
        
        saveStatus()
    }


    func learn(score: Int, isLocated: Bool) {
        let maxScore: Double = 100
        let maxGain = isLocated ? 0.25 : 0.20
        let finalScore = (Double(score) * maxGain) / maxScore
        let newKnowledge = min(1.0, petStatus.knowledge + finalScore)
        
        petStatus = PetStatus(
            knowledge: newKnowledge,
            hunger: petStatus.hunger,
            hint: petStatus.hint
        )
        
        saveStatus()
    }


    
    func addHint(count: Int) {
        petStatus = PetStatus(
            knowledge: petStatus.knowledge,
            hunger: petStatus.hunger,
            hint: count
        )
        saveStatus()
    }

    func saveStatus() {
        UserDefaults.standard.set(petStatus.knowledge, forKey: knowledgeKey)
        UserDefaults.standard.set(petStatus.hunger, forKey: hungerKey)
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: lastActiveKey)
        UserDefaults.standard.set(petStatus.hint, forKey: hintCountKey)
    }
}
