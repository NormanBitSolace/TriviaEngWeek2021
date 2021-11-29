import SwiftUI

struct ContentView: View {

    private var viewModel = PlayViewModel()

    var body: some View {
        MainView()
            .task {
                await viewModel.fetch()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
