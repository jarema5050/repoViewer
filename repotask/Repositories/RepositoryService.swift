//
//  RepositoryService.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 07/12/2022.
//

import Foundation
import RxSwift
import UIKit

struct RepositoryService {
    
    enum Error: Swift.Error {
        case invalidFormat
    }
    
    private var httpService: HTTPService
    
    init(httpService: HTTPService) {
        self.httpService = httpService
    }
    
    private func typed(infos: [RepositoryInfo], source: RepositorySource) -> [RepositoryInfo] {
        infos.map {
            var repository = $0
            repository.repositorySource = source
            return repository
        }
    }
    
    func getBitbucketRepositories() -> Observable<[RepositoryInfo]> {
        let bitbucketObservable: Observable<RepositoryInfoPackage> = self.httpService.fetch(url: RepositorySource.bitbucket.endpoint)
        return bitbucketObservable
            .map(\.values)
            .map { self.typed(infos: $0, source: .bitbucket) }
    }
    
    func getGithubRepositories() -> Observable<[RepositoryInfo]> {
        self.httpService.fetch(url: RepositorySource.github.endpoint)
            .map { self.typed(infos: $0, source: .github) }
    }
    
    func getImage(url: URL) -> Observable<UIImage?> {
        self.httpService.fetch(url: url)
            .map { data in
                guard let image = UIImage(data: data) else {
                    throw Error.invalidFormat
                }
                return image
            }
    }
}
