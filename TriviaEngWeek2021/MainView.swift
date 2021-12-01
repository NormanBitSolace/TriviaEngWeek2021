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
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12)
                ], spacing: 12) {
                    ForEach(0..<24, id: \.self) { number in
                        VStack {
                            if mainViewModel.isFetching {
                                ProgressView()
                            } else {
                                AsyncImage(url: URL(string: mainViewModel.randomDogImageDataObject?.message ?? "")) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    } else if phase.error != nil {
                                        Color.red
                                    } else {
                                        Color.gray
                                    }
                                }
                                .frame(maxWidth: 100, maxHeight: 100, alignment: .center)

                                Text("Category \(number + 1)")
                            }
                        }
                    }
                }
                VStack {
                    NavigationLink("Play", destination: PlayView())
                    NavigationLink("Options", destination: OptionsView())
                }
                .navigationTitle("Trivia")
                .task {
                    await mainViewModel.fetchDogData()
                }
                .padding(.horizontal, 12)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
