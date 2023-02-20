//
//  NetworkLayer.swift
//  CoctailsApp
//
//  Created by Eldar on 12/2/23.
//

import Foundation

final class NetworkLayer {
    
    static let shared = NetworkLayer()
    
    private init() { }
    
    enum ApiType {
        case fetchDrinksByLetter
        case searchDrinkByName
        case lookupDrinkByID
        
        var baseURL: URL {
            .init(string: "www.thecocktaildb.com")!
        }
        
        var path: String {
            switch self {
            case .fetchDrinksByLetter:
                return "/search.php"
            case .searchDrinkByName:
                return "/search.php"
            case .lookupDrinkByID:
                return "/lookup.php"
            }
        }
        
        var components: URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = baseURL.absoluteString
            
            switch self {
            case .fetchDrinksByLetter:
                components.path = "/api/json/v1/1\(ApiType.fetchDrinksByLetter.path)"
            case .searchDrinkByName:
                components.path =  "/api/json/v1/1\(ApiType.searchDrinkByName.path)"
            case .lookupDrinkByID:
                components.path =  "/api/json/v1/1\(ApiType.lookupDrinkByID.path)"
            }
            return components
        }
    }
    
    func fetchDataByLetter(by letter: String) async throws -> Coctail {
        var components = ApiType.fetchDrinksByLetter.components
        components.queryItems = [
            .init(name: "f", value: letter)
        ]
        
        guard let url = components.url else {
            print("URL is nil!")
            return Coctail(drinks: [])
        }
        print(url)
        let (data, _) = try await URLSession.shared.data(from: url)
        return try await decodeData(data: data)
    }
    
    func fetchAllCoctailsData() async throws -> Coctail {
        var coctailsArray = Coctail(drinks: [])
        for letter in UnicodeScalar("a").value...UnicodeScalar("z").value {
            guard let currentLetter = UnicodeScalar(letter) else { break }
            print(currentLetter)
            let fetchedData = try await fetchDataByLetter(
                by: String(currentLetter)
            ).drinks ?? []
            coctailsArray.drinks?.append(contentsOf: fetchedData)
        }
        return coctailsArray
    }
    
    private func decodeData<T: Decodable>(data: Data) async throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
