import SwiftUI

@MainActor
class ImageViewModel: ObservableObject {
    @Published var randomDogUrls: [URL]?
    @Published var imageUrls: [URL]?
    private var networking = Networking()
    
    init() {
    }
    
    func url(forIndex index: Int) -> URL {
        randomDogUrls![index]
    }

    func fetchDogUrls() async {
        randomDogUrls = await networking.getDogUrls()
    }
    
    func fetchImgUrls() async {
        imageUrls = await networking.getRelatedImageUrls()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ImageViewModel()
    @State private var urlsDownloaded = false
    
    var body: some View {
        NavigationView {
            if let _ = viewModel.randomDogUrls, let _ = viewModel.imageUrls {
                JeopardyView()
                    .environmentObject(viewModel)
            } else {
                ProgressView()
            }
        }
        .task {
            await viewModel.fetchDogUrls()
            await viewModel.fetchImgUrls()
            urlsDownloaded = true
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
