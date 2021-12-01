/*
{
      "category": "General%20Knowledge",
      "type": "multiple",
      "difficulty": "medium",
      "question": "Who%20is%20the%20founder%20of%20%22The%20Lego%20Group%22%3F",
      "correct_answer": "Ole%20Kirk%20Christiansen",
      "incorrect_answers": [
        "%20Jens%20Niels%20Christiansen",
        "Kirstine%20Christiansen",
        "%20Gerhardt%20Kirk%20Christiansen"
      ]
    }
 */
import Foundation

struct OpenTriviaModel: Codable {
    let responseCode: Int
    let results: [TriviaModel]
}

struct TriviaModel: Codable {
    let category: String
    let difficulty: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}
