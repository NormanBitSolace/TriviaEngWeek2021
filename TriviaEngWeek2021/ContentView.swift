import SwiftUI

@MainActor
class ImageViewModel: ObservableObject {
    @Published var randomDogUrls: [URL]?
    private var networking = Networking()
    
    init() {
    }
    
    func url(forIndex index: Int) -> URL {
        randomDogUrls![index]
    }

    func fetchDogUrls() async {
        randomDogUrls = await networking.getDogUrls()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ImageViewModel()
    @State private var urlsDownloaded = false
    
    var body: some View {
        NavigationView {
            if let _ = viewModel.randomDogUrls {
                JeopardyView()
                    .environmentObject(viewModel)
            } else {
                ProgressView()
            }
        }
        .task {
            await viewModel.fetchDogUrls()
            urlsDownloaded = true
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
