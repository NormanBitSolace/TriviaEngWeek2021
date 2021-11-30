import Combine

class PlayViewModel: ObservableObject {
    @Published var questionAnswers: [QuestionAnswersViewModel] = []
    var currentRound = 0
    var currentRecord: QuestionAnswersViewModel? {
        guard currentRound < questionAnswers.count else { return nil }
        return questionAnswers[currentRound]
    }

    init() {}

    func fetch() async {
        Task {
            do {
                questionAnswers = try await Test.fetchTrivia()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
