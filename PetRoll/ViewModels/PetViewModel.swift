import Foundation
import Combine

class PetViewModel: ObservableObject {
    @Published private(set) var petStatus: PetStatus

    private var timer: Timer?
    private let decayRate = 0.01 / 60.0 // 1% per menit

    private let knowledgeKey = "knowledgePet"
    private let hungerKey = "hungerPet"
    private let lastActiveKey = "lastActivePet"

    init() {
        let savedKnowledge = UserDefaults.standard.double(forKey: knowledgeKey)
        let savedHunger = UserDefaults.standard.double(forKey: hungerKey)
        let lastActive = UserDefaults.standard.double(forKey: lastActiveKey)
        let currentTime = Date().timeIntervalSince1970

        let elapsedTime = currentTime - lastActive
        let decayAmount = elapsedTime * decayRate

        let knowledge = max(savedKnowledge - decayAmount, 0.0)
        let hunger = max(savedHunger - decayAmount, 0.0)
        

        petStatus = PetStatus(knowledge: knowledge, hunger: hunger)

        startTimer()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.decayStats()
        }
    }

    private func decayStats() {
        petStatus.knowledge = max(petStatus.knowledge - 0.01, 0.0)
        petStatus.hunger = max(petStatus.hunger - 0.01, 0.0)
        saveStatus()
    }

    func feed(isLocated: Bool) {
        let increaseAmount = isLocated ? 0.10 : 0.05
        petStatus.hunger = min(petStatus.hunger + increaseAmount, 1.0)
        saveStatus()
    }


    func learn(score: Int, isLocated: Bool) {
        let maxScore: Double = 100
        let maxGain = isLocated ? 0.25 : 0.20
        let finalScore = (Double(score) * maxGain) / maxScore
        petStatus.knowledge = min(1.0, petStatus.knowledge + finalScore)
        saveStatus()
    }




    func saveStatus() {
        UserDefaults.standard.set(petStatus.knowledge, forKey: knowledgeKey)
        UserDefaults.standard.set(petStatus.hunger, forKey: hungerKey)
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: lastActiveKey)
    }
}
