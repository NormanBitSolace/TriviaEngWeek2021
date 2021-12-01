import SwiftUI

struct RandomDogImageDataObject: Decodable {
    let message, status: String
}

class ImageViewModel: ObservableObject {
    @Published var randomDogUrls: [String]?
    
    init() {
    }
    
    func url(forIndex index: Int) -> URL {
//        guard index < randomDogUrls.count else { fatalError() }
        if let urlString = randomDogUrls?[index] {
            return URL(string: urlString)!
        }
        fatalError()
    }

    //  Make parallel
    @MainActor
    func fetchDogData() async {
        let urlString = "https://dog.ceo/api/breeds/image/random"
        guard let url = URL(string: urlString) else { return }
        
        do {
            var urlStrings = [String]()
            for _ in 0..<24 {
                let (data, _) = try await URLSession.shared.data(from: url)
                let randomDogImageDataObject = try JSONDecoder().decode(RandomDogImageDataObject.self, from: data)
                urlStrings.append(randomDogImageDataObject.message)
            }
            randomDogUrls = urlStrings
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}

struct ContentView: View {
    @StateObject var viewModel = ImageViewModel()
    
    var body: some View {
        VStack {
            if let _ = viewModel.randomDogUrls {
                JeopardyView()
                    .environmentObject(viewModel)
            } else {
                ProgressView()
            }
        }
        .task {
            await viewModel.fetchDogData()
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
