//
//  JeopardyView.swift
//  TriviaEngWeek2021
//
//  Created by Maribel Montejano on 12/1/21.
//

import SwiftUI

// 1) list of categories
// 2) grid

struct JeopardyView: View {
    @EnvironmentObject var viewModel: ImageViewModel
    let columns = Array(repeating: GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12, alignment: .top), count: 3)
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(Array(zip(categories.indices, categories)), id: \.0) { index, category in
                cellView(category: category, index: index)
            }
        }
    }

    func cellView(category: CategoryModel, index: Int) -> some View {
        Button {
            NavigationLink(category.name) {
                PlayView(categoryId: category.id, categoryName: category.name)
            }
        } label: {
            AsyncImage(url: viewModel.url(forIndex: index)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }

        }

    }
}
//
//struct JeopardyView_Previews: PreviewProvider {
//    static var previews: some View {
//        JeopardyView()
//    }
//}
