//import SwiftUI
//
//class ProgressManager: ObservableObject {
//    @AppStorage("lastOpenTime") private var lastOpenTime: Double = Date().timeIntervalSince1970
//    @AppStorage("knowledgeLevel") private var storedKnowledge: Double = 0.59
//    @AppStorage("hungerLevel") private var storedHunger: Double = 0.59
//
//    @Published var knowledge: Double = 0.59
//    @Published var hunger: Double = 0.59
//    @Published var health: Double = 0.59
//
//    private var timer: Timer?
//
//    init() {
//        loadProgress()
//        startTimer()
//    }
//
//    private func loadProgress() {
//        let currentTime = Date().timeIntervalSince1970
//        let elapsedMinutes = (currentTime - lastOpenTime) / 60
//        let decreaseAmount = min(elapsedMinutes * 0.01, 1.0)
//
//        knowledge = max(storedKnowledge - decreaseAmount, 0.0)
//        hunger = max(storedHunger - decreaseAmount, 0.0)
//        updateHealth()
//
//        storedKnowledge = knowledge
//        storedHunger = hunger
//        lastOpenTime = currentTime
//    }
//
//    private func startTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
//            self.decreaseStats()
//        }
//    }
//
//    private func decreaseStats() {
//        if knowledge > 0.0 { knowledge -= 0.01 }
//        if hunger > 0.0 { hunger -= 0.01 }
//
//        storedKnowledge = knowledge
//        storedHunger = hunger
//        lastOpenTime = Date().timeIntervalSince1970
//
//        updateHealth()
//    }
//
//    private func updateHealth() {
//        health = (knowledge + hunger) / 2.0
//    }
//
//    func feed() {
//        hunger = min(hunger + 0.05, 1.0)
//        storedHunger = hunger
//        updateHealth()
//    }
//
//    func learn() {
//        knowledge = min(knowledge + 0.05, 1.0)
//        storedKnowledge = knowledge
//        updateHealth()
//    }
//}
