import Combine

class PlayViewModel: ObservableObject {
    @Published var triviaRecords: [TriviaModel] = []
    var currentRound = 0
    var currentRecord: TriviaModel? {
        guard currentRound < triviaRecords.count else { return nil }
        return triviaRecords[currentRound]
    }

    init() {}

    func fetch() async {
        Task {
            do {
                triviaRecords = try await Test.fetchTrivia()
                print(triviaRecords)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
