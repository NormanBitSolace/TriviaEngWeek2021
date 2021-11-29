import SwiftUI

struct PlayView: View {
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
        .navigationTitle("Entertainment: Comics")
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlayView()
        }
    }
}
