//
//  RepositoryService.swift
//  repotask
//
//  Created by Anna Wąsowicz on 07/12/2022.
//

import Foundation
import RxSwift
import UIKit

struct RepositoryService {
    
    enum Error: Swift.Error {
        case invalidFormat
    }
    
    var httpService: HTTPService
    
    private func typed(infos: [RepositoryInfo], source: RepositorySource) -> [RepositoryInfo] {
        infos.map {
            var repository = $0
            repository.repositorySource = source
            return repository
        }
    }
    
    func getBitbucketRepositories() -> Observable<[RepositoryInfo]> {
        let bitbucketObservable: Observable<RepositoryInfoPackage> = httpService.fetch(url: RepositorySource.bitbucket.endpoint!)
        return bitbucketObservable
            .map(\.values)
            .map { self.typed(infos: $0, source: .bitbucket) }
    }
    
    func getGithubRepositories() -> Observable<[RepositoryInfo]> {
        httpService.fetch(url: RepositorySource.github.endpoint!)
            .map { self.typed(infos: $0, source: .github) }
    }
    
    func getImage(url: URL) -> Observable<UIImage?> {
        httpService.fetch(url: url)
            .map { data in
                guard let image = UIImage(data: data) else {
                    throw Error.invalidFormat
                }
                return image
            }
    }
}
