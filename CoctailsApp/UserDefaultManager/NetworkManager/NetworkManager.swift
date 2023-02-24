//
//  NetworkLayer.swift
//  CocktailsApp
//
//  Created by Eldar on 12/2/23.
//

import Foundation
import RxSwift

enum ApiType {
    case fetchDrinksByName, fetchDrinksByLetter
    
    var baseURL: String {
        "www.thecocktaildb.com"
    }
    
    var path: String {
        switch self {
        case .fetchDrinksByName: return "/api/json/v1/1/search.php/search.php"
        case .fetchDrinksByLetter: return "/api/json/v1/1/search.php/search.php"
        }
    }
    
    var parameterKeys: String {
        switch self {
        case .fetchDrinksByName: return "s"
        case .fetchDrinksByLetter: return "f"
        }
    }
    
    var components: URLComponents  {
        var components = URLComponents()
        components.scheme = "https"
        components.host = self.baseURL
        components.path = self.path
        return components
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let session = URLSession(configuration: .default)
    
    private init () { }
    
    private func decode<T: Decodable>(from data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
    
//    enum ApiType {
//        case fetchDrinksByLetter
//        case searchDrinkByName
//        case lookupDrinkByID
//
//        var baseURL: URL {
//            .init(string: "www.thecocktaildb.com")!
//        }
//
//        var path: String {
//            switch self {
//            case .fetchDrinksByLetter:
//                return "/search.php"
//            case .searchDrinkByName:
//                return "/search.php"
//            case .lookupDrinkByID:
//                return "/lookup.php"
//            }
//        }
//
//        var components: URLComponents {
//            var components = URLComponents()
//            components.scheme = "https"
//            components.host = baseURL.absoluteString
//
//            switch self {
//            case .fetchDrinksByLetter:
//                components.path = "/api/json/v1/1\(ApiType.fetchDrinksByLetter.path)"
//            case .searchDrinkByName:
//                components.path =  "/api/json/v1/1\(ApiType.searchDrinkByName.path)"
//            case .lookupDrinkByID:
//                components.path =  "/api/json/v1/1\(ApiType.lookupDrinkByID.path)"
//            }
//            return components
//        }
//    }
    
    private func generateURLForApiType(_ apiType: ApiType, paramsValue: String) -> URL? {
        var components = apiType.components
        components.queryItems = [
            .init(name: apiType.parameterKeys, value: paramsValue)
        ]
        return components.url
    }
    
    func fetchDataByLetter(by letter: String) async throws -> Cocktail {
        var components = ApiType.fetchDrinksByLetter.components
        components.queryItems = [
            .init(name: "f", value: letter.lowercased())
        ]
        
        guard let url = components.url else {
            print("URL is nil!")
            return Cocktail(drinks: [])
        }
        print(url)
        let (data, _) = try await URLSession.shared.data(from: url)
        return try await decodeData(data: data)
    }
    
    public func getCocktailsWithLetter(_ letter: String) async throws -> Cocktail {
        guard let url = generateURLForApiType(
            .fetchDrinksByLetter,
            paramsValue: letter
        ) else {
            print("Network Manager Error. URL is nil in getCocktailsWithLetter(_ letter: String)  method. Returning empty object.")
            return Cocktail()
        }
        print("URL for letter \"\(letter)\" is: \(url)")
        let (data, _) =  try await session.data(from: url)
        return try decode(from: data)
    }
    
    
    func fetchAllCocktailsData() async throws -> Cocktail {
        var cocktailsArray = Cocktail(drinks: [])
        for letter in UnicodeScalar("a").value...UnicodeScalar("z").value {
            guard let currentLetter = UnicodeScalar(letter) else { break }
            print(currentLetter)
            let fetchedData = try await fetchDataByLetter(
                by: String(currentLetter)
            ).drinks ?? []
            cocktailsArray.drinks?.append(contentsOf: fetchedData)
        }
        return cocktailsArray
    }
    
    private func decodeData<T: Decodable>(data: Data) async throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    public func getCocktailsWithName(_ name: String) async throws -> Cocktail {
        guard let url = generateURLForApiType(
            .fetchDrinksByName,
            paramsValue: name
        ) else {
            print("Network Manager Error. URL is nil in getCocktailsWithName(_ name: String) method. Returning empty object.")
            return Cocktail()
        }
        print("URL for name \"\(name)\" is: \(url)")
        let (data, _) =  try await session.data(from: url)
        return try decode(from: data)
    }
}
