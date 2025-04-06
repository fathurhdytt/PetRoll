import Foundation

struct Quiz: Decodable {
    var quizTitle: String
    var questions: [Question]
}

struct Question: Codable {
    var question: String
    var answer: String
    var hint: String
}
