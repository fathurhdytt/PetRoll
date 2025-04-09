import Foundation
import Combine

class QuizViewModel: ObservableObject {
    @Published var quiz: Quiz
    @Published var currentQuestionIndex = 0
    @Published var userAnswer = ""
    @Published var score = 0
    @Published var isFinished = false
    @Published var timeRemaining = 10.0 // Mulai dari 10 detik
    
    @Published var hintCount: Int = 3
    @Published var isHintShown: Bool = false
    
    @Published var lives: Int = 3
    
    
    private var randomizedQuestions: [Question] = []
    private var timer: Timer?
    
    let totalTimePerQuestion: Double = 10.0

    var totalQuestions: Int {
        randomizedQuestions.count
    }

    var currentQuestion: Question {
        randomizedQuestions[currentQuestionIndex]
    }

    init(quiz: Quiz) {
        self.quiz = quiz
        let questions = quiz.questions.shuffled()
        self.randomizedQuestions = Array(questions.prefix(min(10, questions.count)))
        
        // Tambahan pengaman
        if !randomizedQuestions.isEmpty {
            startTimer()
        }
    }


    func submitAnswer() -> Bool {
        timer?.invalidate()
        
        let userAnswerTrimmed = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let correctAnswer = currentQuestion.answer.lowercased()
        
        let isCorrect = userAnswerTrimmed == correctAnswer

        if isCorrect {
            // Skor dihitung berdasarkan sisa waktu (maksimal 10 poin)
            let bonus = Int(timeRemaining.rounded())
            score += bonus + 1 // 1 poin untuk benar, bonus dari sisa waktu
        } else {
            decreaseLife()
        }

        nextQuestion()
        return isCorrect
    }


    func startTimer() {
        timeRemaining = totalTimePerQuestion
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] t in
            guard let self = self else { return }
            self.timeRemaining -= 0.1
            if self.timeRemaining <= 0 {
                t.invalidate()
                self.nextQuestion() // Auto-skip
            }
        }
    }

    func nextQuestion() {
        userAnswer = ""
        isHintShown = false // reset supaya bisa pakai hint lagi

        if currentQuestionIndex < randomizedQuestions.count - 1 {
            currentQuestionIndex += 1
            startTimer()
        } else {
            isFinished = true
        }
    }


    
    func useHintIfAvailable() {
        if !isHintShown && hintCount > 0 {
            isHintShown = true
            hintCount -= 1
            print("🎯 Hint digunakan! Hint count sekarang: \(hintCount)")
        } else if isHintShown {
            print("🔁 Hint sudah ditampilkan sebelumnya.")
        } else {
            print("❌ Tidak ada hint yang tersisa.")
        }
    }


    func decreaseLife() {
        if lives > 0 {
            lives -= 1
        }
        if lives == 0 {
            isFinished = true
        }
    }


    deinit {
        timer?.invalidate()
    }
}
