import SwiftUI

//class MainViewModel: ObservableObject {
//    @Published var isFetching = false
//    @Published var randomDogImageDataObjects = [RandomDogImageDataObject]()
//    var categories: [Int: String] = [
//        9: "General Knowledge",
//        10: "Entertainment: Books",
//        11: "Entertainment: Film",
//        12: "Entertainment: Music",
//        13: "Entertainment: Musicals & Theatres",
//        14: "Entertainment: Television",
//        15: "Entertainment: Video Games",
//        16: "Entertainment: Board Games",
//        17: "Science & Nature",
//        18: "Science: Computers",
//        19: "Science: Mathematics",
//        20: "Mythology",
//        21: "Sports",
//        22: "Geography",
//        23: "History",
//        24: "Politics",
//        25: "Art",
//        26: "Celebrities",
//        27: "Animals",
//        28: "Vehicles",
//        29: "Entertainment: Comics",
//        30: "Science: Gadgets",
//        31: "Entertainment: Japanese Anime & Manga",
//        32: "Entertainment: Cartoon & Animations"
//    ]
//
//    @MainActor
//    func fetchDogData() async {
//        isFetching = true
//        let urlString = "https://dog.ceo/api/breeds/image/random"
//        guard let url = URL(string: urlString) else { return }
//
//        do {
//            for _ in 0..<24 {
//                let (data, _) = try await URLSession.shared.data(from: url)
//                let randomDogImageDataObject = try JSONDecoder().decode(RandomDogImageDataObject.self, from: data)
//                randomDogImageDataObjects.append(randomDogImageDataObject)
//            }
//            isFetching = false
//        } catch {
//            isFetching = false
//            print("Error fetching data: \(error)")
//        }
//
//    }
//}
//
//struct TriviaJeopardyView: View {
//    @ObservedObject var mainViewModel = MainViewModel()
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                LazyVGrid(columns: [
//                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12, alignment: .top),
//                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12, alignment: .top),
//                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12, alignment: .top)
//                ], spacing: 12) {
//                    ForEach(0..<24, id: \.self) { number in
//                        VStack {
//                            if mainViewModel.isFetching {
//                                ProgressView()
//                            } else {
//                                if let randomDogImageDataObjects = mainViewModel.randomDogImageDataObjects, !randomDogImageDataObjects.isEmpty {
//                                    let url = URL(string: randomDogImageDataObjects[number].message)
//                                    AsyncImage(url: url) { phase in
//                                        if let image = phase.image {
//                                            image
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fit)
//                                        } else if phase.error != nil {
//                                            Color.red
//                                        } else {
//                                            Color.gray
//                                        }
//                                    }
//                                    .frame(maxWidth: 100, maxHeight: 100, alignment: .center)
//                                }
//
//                                Text(mainViewModel.categories[number + 9] ?? "")
//                                    .font(.system(size: 14, weight: .medium))
//                            }
//                        }
//                    }
//                }
//                VStack {
//                    NavigationLink("Play", destination: PlayView())
//                    NavigationLink("Options", destination: OptionsView())
//                }
//                .navigationTitle("Trivia")
//                .task {
//                    await mainViewModel.fetchDogData()
//                }
//                .padding(.horizontal, 12)
//            }
//        }
//    }
//}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        TriviaJeopardyView()
//    }
//}
