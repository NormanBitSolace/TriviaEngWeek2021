import SwiftUI

struct PlayView: View {
    let categoryId: Int
    let categoryName: String
    @State var triviaModel: TriviaViewModel?
    @State var showingAlert = false
    var networking = Networking()
    @State var message = ""

    var body: some View {
        Group {
            if let triviaModel = triviaModel {
                triviaView(triviaModel)
            } else {
                loadingView
            }
        }
        .task {
            do {
                triviaModel = try await networking.fetchTrivia(category: categoryId)
            } catch {
                triviaModel = nil
            }
        }
        .alert(message, isPresented: $showingAlert) {
            Button("OK") { }
        }
    }

    private var loadingView: some View {
        ProgressView()
    }

    private func triviaView(_ model: TriviaViewModel) -> some View {
        return VStack {
            Text(model.title)
                .font(.title)
                .padding(.bottom)
            Text(model.question)
                .padding(.bottom)
            ForEach(0..<model.answers.count) { index in
                Button(model.answers[index]) {
                    handleTap(index: index, model: model)
                }
                .padding()
            }
        }
        .padding()
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text(accessibityText(model)))

    }

    private func handleTap(index: Int, model: TriviaViewModel) {
        let isCorrect = index == triviaModel?.correctAnswerIndex
        message = isCorrect ? "Correct" : "Incorrect"
        showingAlert = true
    }

    private func accessibityText(_ model: TriviaViewModel) -> String {
        var text = """
        The category is \(model.title),,
        Question,
        \(model.question),,
        There are \(model.answers.count) choices to pick from,,
        """
        for answer in model.answers {
            text += "\(answer),"
        }

        return text
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView(categoryId: 27, categoryName: "Animals")
    }
}
