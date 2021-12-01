import SwiftUI

struct PlayView: View {
    @EnvironmentObject var viewModel: PlayViewModel

    var body: some View {
        if let triviaRecord = viewModel.currentRecord {
            triviaView(triviaRecord)
        } else {
            loadingView
        }
    }

    private var loadingView: some View {
        ProgressView()
    }

    private func triviaView(_ triviaRecord: TriviaViewModel) -> some View {
        return VStack {
            Text(triviaRecord.title)
            Text(triviaRecord.question)
            ForEach(0..<triviaRecord.answers.count) { index in
                Button(triviaRecord.answers[index]) {
                    print("Answer \(index)")
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text(accessibityText(triviaRecord)))

    }

    private func accessibityText(_ triviaRecord: TriviaViewModel) -> String {
        var text = """
        The category is \(triviaRecord.title),,
        Question,
        \(triviaRecord.question),,
        There are \(triviaRecord.answers.count) choices to pick from,,
        """
        for answer in triviaRecord.answers {
            text += "\(answer),"
        }

        return text
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
