import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Image("banner")
            NavigationLink("Play", destination: PlayView())
            NavigationLink("Options", destination: OptionsView())
        }
        .navigationTitle("Trivia")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
