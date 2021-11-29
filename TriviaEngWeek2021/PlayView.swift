import SwiftUI

struct PlayView: View {
    @EnvironmentObject var viewModel: PlayViewModel

    var body: some View {
        VStack {
            Text("Question")
            Button("Answer 1") {
                print("Answer 1")
            }
            Button("Answer 2") {
                print("Answer 2")
            }
            Button("Answer 3") {
                print("Answer 3")
            }
            Button("Answer 4") {
                print("Answer 4")
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text(accessibityText(model: viewModel.currentRecord)))
        .navigationTitle("Entertainment: Comics")
    }

    private func accessibityText(model: TriviaModel?) -> String {
        guard let model = model else { return "There was an error." }
        var text = """
        Question,
        \(model.question),,
        """
        if model.isTrueFalse() {
            text += "True, or, False"
        } else {
            text += "There are \(model.answers.count) choices to pick from,,"
            for answer in model.answers {
                text += "\(answer),"
            }
        }

        return text
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
