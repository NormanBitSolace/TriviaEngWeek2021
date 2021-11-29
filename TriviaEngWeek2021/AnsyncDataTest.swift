import Foundation

enum NetworkError: Error {
    case urlError
    case corruptDataError
    case httpError(Int)
}

@MainActor struct Test {

    static func fetchTrivia(numQuestions: Int = 10) async throws -> [TriviaModel] {
        let url = URL(string: "https://opentdb.com/api.php?amount=\(numQuestions)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.urlError
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(httpResponse.statusCode)
        }
        if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: []),
           let dict = jsonObj as? [String: Any] {
            return TriviaModel.parseJson(dict: dict)
        } else {
            throw NetworkError.corruptDataError
        }
    }
}
