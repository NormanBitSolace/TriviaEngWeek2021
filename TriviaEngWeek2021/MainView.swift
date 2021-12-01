import SwiftUI

struct RandomDogImageDataObject: Decodable {
    let message, status: String
}

class MainViewModel: ObservableObject {
    @Published var isFetching = false
    @Published var randomDogImageDataObject: RandomDogImageDataObject?

    @MainActor
    func fetchDogData() async {
        isFetching = true
        let urlString = "https://dog.ceo/api/breeds/image/random"
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.randomDogImageDataObject = try JSONDecoder().decode(RandomDogImageDataObject.self, from: data)
            isFetching = false
        } catch {
            isFetching = false
            print("Error fetching data: \(error)")
        }
        
    }
}

struct MainView: View {
    @ObservedObject var mainViewModel = MainViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if mainViewModel.isFetching {
                    ProgressView()
                } else {
                    AsyncImage(url: URL(string: mainViewModel.randomDogImageDataObject?.message ?? ""))
                }
                NavigationLink("Play", destination: PlayView())
                NavigationLink("Options", destination: OptionsView())
            }
            .navigationTitle("Trivia")
            .task {
                await mainViewModel.fetchDogData()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
