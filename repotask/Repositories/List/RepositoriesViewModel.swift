//
//  RepositoriesViewModel.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 06/12/2022.
//

import UIKit
import RxSwift

class RepositoriesViewModel: ViewModel {
    var disposeBag = DisposeBag()
    
    var input: Input
    
    var output: Output
    
    struct Input { }
    
    struct Output {
        var repositories: Observable<[RepositoryInfoListDTO]>
        //var selected: Observable<RepositoryInfo>
    }
    
    init(repositoryService: RepositoryService) {
        let repositoryDTOs = Observable.combineLatest(
            repositoryService.getBitbucketRepositories(),
            repositoryService.getGithubRepositories()
        ) {
            $0 + $1
        }
            .map {
                $0.map { RepositoryInfoListDTO(parent: $0, repositoryService: repositoryService) }
            }
        
        self.input = Input()
        self.output = Output(repositories: repositoryDTOs)
    }
}
