import Foundation

struct CategoryModel: Identifiable {
    let id: Int
    let name: String
}


// https://dog.ceo/api/breeds/image/random

let categories: [CategoryModel] = [
    CategoryModel(id: 9, name: "General Knowledge"),
    CategoryModel(id: 10, name: "Books"),
    CategoryModel(id: 11, name: "Film"),
    CategoryModel(id: 12, name: "Music"),
    CategoryModel(id: 13, name: "Musicals & Theatres"),
    CategoryModel(id: 14, name: "Television"),
    CategoryModel(id: 15, name: "Video Games"),
    CategoryModel(id: 16, name: "Board Games"),
    CategoryModel(id: 17, name: "Science & Nature"),
    CategoryModel(id: 18, name: "Computers"),
    CategoryModel(id: 19, name: "Mathematics"),
    CategoryModel(id: 20, name: "Mythology"),
    CategoryModel(id: 21, name: "Sports"),
    CategoryModel(id: 22, name: "Geography"),
    CategoryModel(id: 23, name: "History"),
    CategoryModel(id: 24, name: "Politics"),
    CategoryModel(id: 25, name: "Art"),
    CategoryModel(id: 26, name: "Celebrities"),
    CategoryModel(id: 27, name: "Animals"),
    CategoryModel(id: 28, name: "Vehicles"),
    CategoryModel(id: 29, name: "Comics"),
    CategoryModel(id: 30, name: "Gadgets"),
    CategoryModel(id: 31, name: "Japanese Anime & Manga"),
    CategoryModel(id: 32, name: "Cartoon & Animations")
]

/*
     private func cellView(category: CategoryModel) -> some View {
        Button (action: {
            NavigationLink("Play", destination: PlayView(category: category))
        }, label: {
            Text("h")
            AsyncImage(url: category.url, content: { phase in
                phase.image
                    .resizable()
                    .frame(maxWidth: 100, maxHeight: 100, alignment: .center)
            }, placeholder: ProgressView())
    })

     var categories: [Int: String] = [
        9: "General Knowledge",
        10: "Entertainment: Books",
        11: "Entertainment: Film",
        12: "Entertainment: Music",
        13: "Entertainment: Musicals & Theatres",
        14: "Entertainment: Television",
        15: "Entertainment: Video Games",
        16: "Entertainment: Board Games",
        17: "Science & Nature",
        18: "Science: Computers",
        19: "Science: Mathematics",
        20: "Mythology",
        21: "Sports",
        22: "Geography",
        23: "History",
        24: "Politics",
        25: "Art",
        26: "Celebrities",
        27: "Animals",
        28: "Vehicles",
        29: "Entertainment: Comics",
        30: "Science: Gadgets",
        31: "Entertainment: Japanese Anime & Manga",
        32: "Entertainment: Cartoon & Animations"
    ]

 */
