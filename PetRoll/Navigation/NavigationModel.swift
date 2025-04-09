import SwiftUI

class NavigationViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var currentQuiz: Quiz?
    @Published var currentScore: Int = 0
    @Published var isLocated: Bool = false
    @Published var petViewModel: PetViewModel = PetViewModel()

    func goToPreviewQuiz(petViewModel: PetViewModel, isLocated: Bool) {
        self.petViewModel = petViewModel
        self.isLocated = isLocated
        path.append(AppRoute.previewQuiz)
    }

    func goToQuiz(quiz: Quiz, petViewModel: PetViewModel, isLocated: Bool) {
        self.currentQuiz = quiz
        self.petViewModel = petViewModel
        self.isLocated = isLocated
        path.append(AppRoute.quiz)
    }

    func goToFinish(score: Int, petViewModel: PetViewModel, isLocated: Bool) {
        self.currentScore = score
        self.petViewModel = petViewModel
        self.isLocated = isLocated
        path.append(AppRoute.finish)
    }

    func goToRoot() {
        path = NavigationPath()
    }
}
