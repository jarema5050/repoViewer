//
//  RepositoryDetailViewModel.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 07/12/2022.
//

import Foundation
import RxSwift
import UIKit

class RepositoryDetailViewModel: ViewModel {
    var input: Input
    
    var output: Output
    
    struct Input {}
    
    struct Output {
        var avatarImage: Observable<UIImage?>
    }
    
    var repository: RepositoryInfo
    
    init(repositoryService: RepositoryService, repository: RepositoryInfo) {
        let avatarImageObservable = repository.avatarImage(repositoryService: repositoryService)
        self.input = Input()
        self.output = Output(
            avatarImage: avatarImageObservable ?? .just(UIImage(systemName: "multiply.circle.fill"))
        )
        
        self.repository = repository
    }
}

fileprivate extension RepositoryInfo {
    func avatarImage(repositoryService: RepositoryService) -> Observable<UIImage?>? {
        if let url = self.owner.avatarUrl {
            return repositoryService.getImage(url: url)
        }
        
        return nil
    }
}
