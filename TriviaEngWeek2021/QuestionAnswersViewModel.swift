import Foundation

struct QuestionAnswersViewModel: Codable {
    let title: String
    let level: String
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
}

extension QuestionAnswersViewModel {
    init(with model: QuestionAnswersModel) {
        self.title = String(htmlEncodedString: model.category)
        self.level = model.difficulty.capitalized
        self.question = String(htmlEncodedString: model.question)
        self.answers = ([model.correctAnswer] + model.incorrectAnswers).shuffled().map { String(htmlEncodedString: $0) }
        self.correctAnswerIndex = answers.firstIndex(where: { answer in
            answer == String(htmlEncodedString: model.correctAnswer)
        }) ?? 0
    }
}

extension String {

    init(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            fatalError()
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            fatalError()
        }

        self.init(attributedString.string)

    }

}
