import Combine

class PlayViewModel: ObservableObject {
    @Published var triviaRecords: [TriviaModel] = []

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
