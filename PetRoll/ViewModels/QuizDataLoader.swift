import Foundation

class QuizDataLoader {
    static func loadQuiz() -> Quiz? {
        guard let url = Bundle.main.url(forResource: "QuizData", withExtension: "json") else {
            print("❌ Gagal menemukan QuizData.json di bundle.")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let quiz = try JSONDecoder().decode(Quiz.self, from: data)
            return quiz
        } catch {
            print("❌ Gagal decode: \(error)")
            return nil
        }
    }
}
