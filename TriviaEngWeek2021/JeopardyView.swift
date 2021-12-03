import SwiftUI

struct JeopardyView: View {
    @EnvironmentObject var viewModel: ImageViewModel
    let columns = Array(repeating: GridItem(.flexible(minimum: 80, maximum: 100), spacing: 16, alignment: .top), count: 3)
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 4) {
                ForEach(Array(zip(categories.indices, categories)), id: \.0) { index, category in
                    cellView(category: category, index: index)
                }
            }
            .padding(.horizontal, 10)
            .navigationTitle("Trivia")
        }
    }

    func cellView(category: CategoryModel, index: Int) -> some View {
        NavigationLink {
            PlayView(categoryId: category.id, categoryName: category.name)
        } label: {
            VStack {
                AsyncImage(url: viewModel.url(forIndex: index)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80, alignment: .top)
                        .cornerRadius(15)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                Text(category.name)
                    .font(.system(size: 14, weight: .medium))
            }
        }
    }
}

struct JeopardyView_Previews: PreviewProvider {
    static var previews: some View {
        JeopardyView()
    }
}
