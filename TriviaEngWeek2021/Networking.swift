import Foundation

enum NetworkError: Error {
    case urlError
    case corruptDataError
    case httpError(Int)
}

class Networking: ObservableObject {
    func createURL() -> URL {
        let url = URL(string: "https://pixabay.com/api/")!
        return url
    }

    func queryURL(categoryName: String) -> URL {
        let pictureQuery: [String: String] = [
            "key": apiKey,
            "q": categoryName,
            "image_type": "photo",
            "per_page": "3"
        ]
        return self.createURL().withQueries(pictureQuery)!
    }

    func getRelatedImageUrl() async -> URL? {
        struct RelatedImageObject: Decodable {
            let total, totalHits: Int
            let hits: [Hits]
        }

        struct Hits: Codable {
            let id: Int
            let pageURL: String
            let type: String
            let tags: String
            let previewURL: String
        }

        let url = self.queryURL(categoryName: categories[0].name)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let relatedImageObject = try JSONDecoder().decode(RelatedImageObject.self, from: data)
            let previewURL = URL(string: relatedImageObject.hits.first!.previewURL)
            return previewURL
        } catch {
            return nil
        }
    }

    func getDogUrls() async -> [URL] {
        return await withTaskGroup(of: String.self) { group in
            var urls = [URL]()

            for _ in 0..<24 {
                group.addTask {
                    return await self.getRandomUrl()
                }
            }

            for await url in group {
                if let url = URL(string: url) {
                    urls.append(url)
                }
            }
            return urls
        }
    }

    private func getRandomUrl() async -> String {
        struct RandomDogImageDataObject: Decodable {
            let message, status: String
        }
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let randomDogImageDataObject = try JSONDecoder().decode(RandomDogImageDataObject.self, from: data)
            return randomDogImageDataObject.message
        } catch {
            return ""
        }
    }

    func fetchTrivia(category: Int) async throws -> TriviaViewModel {
        //  &encode=base64, &encode=url3986
        let url = URL(string: "https://opentdb.com/api.php?amount=1&type=multiple&category=\(category)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.urlError
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(httpResponse.statusCode)
        }
        let decoder = JSONDecoder()
        //        decoder.dataDecodingStrategy = .base64
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let triviaRecord = try? decoder.decode(OpenTriviaModel.self, from: data),
           let first = triviaRecord.results.first {
            return TriviaViewModel(with: first)
        } else {
            throw NetworkError.corruptDataError
        }
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
