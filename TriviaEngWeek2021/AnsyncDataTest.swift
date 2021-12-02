import Foundation


@MainActor struct Test {

    static func fetchTrivia(numQuestions: Int = 10) async throws -> [TriviaViewModel] {
        //  &encode=base64, &encode=url3986
        let url = URL(string: "https://opentdb.com/api.php?amount=10&type=multiple")!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.urlError
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(httpResponse.statusCode)
        }
        let decoder = JSONDecoder()
//        decoder.dataDecodingStrategy = .base64
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let triviaRecord = try? decoder.decode(OpenTriviaModel.self, from: data) {
            return triviaRecord.results.map { TriviaViewModel(with: $0)}
        } else {
            throw NetworkError.corruptDataError
        }
    }
}
