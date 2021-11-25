//
//  NetworkManager.swift
//  e-learning
//
//  Created by rvaidya on 24/11/21.
//

import Foundation
import Combine

enum NetworkError: Error {
    case responseError
    case invalidURL
    case unknown
}

protocol NetworkManagement {
    func getData<T:Decodable>(of type: T.Type, url: String) -> Future<T, Error>
}

class NetworkManager: NetworkManagement {
    
    private var cancellables = Set<AnyCancellable>()

    func getData<T: Decodable>(of type: T.Type, url: String) -> Future<T, Error> {
        
        return Future<T, Error> { [weak self] promise in
            guard let self = self, let newURL = URL(string: url) else {return promise(.failure(NetworkError.invalidURL))}
            print("URL \(newURL)")

            URLSession.shared.dataTaskPublisher(for: newURL)
                .tryMap { (data, response) -> Data in
                    guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main, options: .none)
                .sink { completion in
                    // if the completion happens
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingErr as DecodingError:
                            return promise(.failure(decodingErr))
                        case let netError as NetworkError:
                            return promise(.failure(netError))
                        default:
                            return promise(.failure(NetworkError.unknown))
                        }
                    }
                    
                } receiveValue: { value in
                    return promise(.success(value))
                }
                .store(in: &self.cancellables)
        }
    }
}

