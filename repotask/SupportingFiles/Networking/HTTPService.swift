//
//  HTTPService.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 06/12/2022.
//

import Foundation
import RxSwift
import RxCocoa

final class HTTPService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    private func request(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        return request
    }
    
    func fetch<T>(url: URL) -> Observable<T> where T: Decodable {
        self.fetch(url: url)
            .map { data -> T in
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    return try decoder.decode(T.self, from: data)
                } catch let error {
                    throw RxCocoa.RxCocoaURLError.deserializationError(error: error)
                }
            }
    }
    
    func fetch(url: URL) -> Observable<Data> {
        self.session.rx.response(request: self.request(url: url))
            .map(\.data)
    }
}
