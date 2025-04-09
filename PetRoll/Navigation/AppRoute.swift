import SwiftUI

enum AppRoute: Hashable {
    case previewQuiz(petViewModel: PetViewModel)
    case quiz(quiz: Quiz, petViewModel: PetViewModel)
    case finish(score: Int, petViewModel: PetViewModel)

    // Conformance manual karena ada associated values
    static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
        switch (lhs, rhs) {
        case (.previewQuiz, .previewQuiz),
             (.quiz, .quiz),
             (.finish, .finish):
            return true
        default:
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .previewQuiz:
            hasher.combine("previewQuiz")
        case .quiz:
            hasher.combine("quiz")
        case .finish:
            hasher.combine("finish")
        }
    }
}
