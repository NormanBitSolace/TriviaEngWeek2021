import SwiftUI

struct JeopardyView: View {
    @EnvironmentObject var viewModel: ImageViewModel
    let columns = Array(repeating: GridItem(.flexible(minimum: 100, maximum: 100), spacing: 16, alignment: .top), count: 3)
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 4) {
                ForEach(Array(zip(categories.indices, categories)), id: \.0) { index, category in
                    cellView(category: category, index: index)
                }
            }
            .padding(.horizontal, 10)
        }
    }

    func cellView(category: CategoryModel, index: Int) -> some View {
        VStack {
            Button {
                NavigationLink(category.name) {
                    PlayView(categoryId: category.id, categoryName: category.name)
                }
            } label: {
                AsyncImage(url: viewModel.url(forIndex: index)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100, alignment: .top)

            }
            Text(category.name)
                .font(.system(size: 14, weight: .medium))
        }
    }
}

struct JeopardyView_Previews: PreviewProvider {
    static var previews: some View {
        JeopardyView()
    }
}
