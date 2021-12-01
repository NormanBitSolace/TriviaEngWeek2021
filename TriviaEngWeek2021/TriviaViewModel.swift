import Foundation

struct TriviaViewModel: Codable {
    let title: String
    let level: String
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
}

extension TriviaViewModel {
    init(with model: TriviaModel) {
        //  This is the wrong place to decode, should happen initially on model
        self.title = model.category.decoded
        self.level = model.difficulty.capitalized
        self.question = model.question.decoded
        self.answers = ([model.correctAnswer] + model.incorrectAnswers).shuffled().map { $0.decoded }
        self.correctAnswerIndex = answers.firstIndex(where: { answer in
            answer == model.correctAnswer.decoded
        }) ?? 0
    }
}

extension String {

    var decoded: String {
        guard let data = self.data(using: .utf8) else {
            fatalError()
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            fatalError()
        }
        return attributedString.string
    }
}
