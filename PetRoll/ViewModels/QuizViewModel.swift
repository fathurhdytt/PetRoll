import Foundation
import Combine

class QuizViewModel: ObservableObject {
    @Published var quiz: Quiz
    @Published var currentQuestionIndex = 0
    @Published var userAnswer = ""
    @Published var score = 0
    @Published var isFinished = false
    @Published var timeRemaining = 10.0
    
    @Published var hintCount: Int = 3
    @Published var isHintShown: Bool = false
    
    @Published var lives: Int = 3
    
    private var timer: Timer?
    private var randomizedQuestions: [Question] = []
    
    let totalTimePerQuestion: Double = 10.0
    
    private var petViewModel: PetViewModel // <-- Tambah ini

    var totalQuestions: Int {
        randomizedQuestions.count
    }
    
    var currentQuestion: Question {
        randomizedQuestions[currentQuestionIndex]
    }
    
    init(quiz: Quiz, petViewModel: PetViewModel) {
        self.quiz = quiz
        self.petViewModel = petViewModel
        
        let questions = quiz.questions.shuffled()
        self.randomizedQuestions = Array(questions.prefix(min(10, questions.count)))

        // Ambil jumlah hint dari PetStatus
        self.hintCount = petViewModel.petStatus.hint

        if !randomizedQuestions.isEmpty {
            startTimer()
        }
    }


    func submitAnswer(){
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

        print("Jawaban: \(userAnswerTrimmed), Benar: \(isCorrect), Skor sekarang: \(score)")

        nextQuestion()
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
        isHintShown = false

        if currentQuestionIndex < randomizedQuestions.count - 1 {
            currentQuestionIndex += 1
            startTimer()
        } else {
            finishQuiz()
        }
    }

    
    func useHintIfAvailable() {
        if !isHintShown && hintCount > 0 {
            isHintShown = true
            hintCount -= 1
            petViewModel.addHint(count: hintCount) // Simpan ke status
            print("🎯 Hint digunakan! Hint count sekarang: \(hintCount)")
        } else if isHintShown {
            print("🔁 Hint sudah ditampilkan sebelumnya.")
        } else {
            print("❌ Tidak ada hint yang tersisa.")
        }
    }

    private func finishQuiz() {
        isFinished = true

        if score >= 1 {
            hintCount += 1
            petViewModel.addHint(count: hintCount)
            print("🎁 Kuis selesai! Kamu dapat bonus 1 hint 🎉 Hint sekarang: \(hintCount)")
        } else {
            print("❌ Skor belum cukup untuk dapat hint.")
        }
    }


    func decreaseLife() {
        if lives > 0 {
            lives -= 1
        }
        if lives == 0 {
            finishQuiz()
        }
    }

    deinit {
        timer?.invalidate()
    }
}
