import Foundation

struct UrlProvider {
    private let baseUrl: URL
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func url(forPathComponents pathComponents: [String], parameters: [String: String]) -> URL {
        let baseUrlWithPathComponents = url(for: baseUrl, pathComponents: pathComponents)
        return url(for: baseUrlWithPathComponents, parameters: parameters) ?? baseUrlWithPathComponents
    }
}

extension UrlProvider {
    // MARK: - Adding Query Params
    private func url(for url: URL, parameters: [String: String]) -> URL? {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return urlComponents?.url
    }
    
    // MARK: - Adding Path Params
    private func url(for url: URL, pathComponents: [String]) -> URL {
        return pathComponents.reduce(url) { result, pathComponent in
            return result.appendingPathComponent(pathComponent)
        }
    }
}
