//
//  RepositoriesViewModel.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 06/12/2022.
//

import UIKit
import RxSwift
import RxRelay

class RepositoriesViewModel: ViewModel {
    var disposeBag = DisposeBag()
    
    var input: Input
    
    var output: Output
    
    struct Input {
        var sort: AnyObserver<Bool>
    }
    
    struct Output {
        var repositories: Observable<[RepositoryInfoListDTO]>
    }
    
    private var notSorted = [RepositoryInfoListDTO]()
    
    init(repositoryService: RepositoryService) {
        let sort = PublishSubject<Bool>()
        
        self.input = Input(sort: sort.asObserver())
        
        let repositoryDTOs = Observable.combineLatest(
            repositoryService.getBitbucketRepositories(),
            repositoryService.getGithubRepositories()
        ) {
            $0 + $1
        }
            .map {
                $0.map { RepositoryInfoListDTO(parent: $0, repositoryService: repositoryService) }
            }
        
        let sortedRepositoryDTOs = repositoryDTOs
            .map { dtos in
                dtos.sorted { $0.name?.lowercased() ?? "" < $1.name?.lowercased() ?? "" }
            }
        
        self.output = Output(
            repositories: Observable.combineLatest(sort.startWith(false), repositoryDTOs,sortedRepositoryDTOs)
                .map { !$0 ? $1 : $2 }
        )
    }
}
