//
//  RepositoriesViewModel.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 06/12/2022.
//

import UIKit
import RxSwift
import RxReachability
import Reachability

final class RepositoriesViewModel: ViewModel {
    private var disposeBag = DisposeBag()
    
    var input: Input
    
    var output: Output
    
    struct Input {
        var sort: AnyObserver<Bool>
        var refresh: AnyObserver<Void>
    }
    
    struct Output {
        var repositories: Observable<[RepositoryInfoListDTO]>
    }
    
    init(repositoryService: RepositoryService) {
        let sort = BehaviorSubject<Bool>(value: false)
        let refresh = PublishSubject<Void>()
        
        self.input = Input(sort: sort.asObserver(), refresh: refresh.asObserver())
        
        let repositoryDTOs = Observable.combineLatest(
            repositoryService.getBitbucketRepositories(),
            repositoryService.getGithubRepositories()
        ) { $0 + $1 }
            .map {
                $0.map { RepositoryInfoListDTO(parent: $0, repositoryService: repositoryService) }
            }
        
        let sortedRepositoryDTOs = repositoryDTOs
            .map { dtos in
                dtos.sorted {
                    var first = $0
                    var second = $1
                    
                    return first.name?.lowercased() ?? "" < second.name?.lowercased() ?? ""
                }
            }
        
        let refreshed = refresh
            .startWith(())
            .flatMapLatest {
                Observable.combineLatest(sort, repositoryDTOs, sortedRepositoryDTOs)
                    .map { !$0 ? $1 : $2 }
            }
        
        self.output = Output(
            repositories: refreshed
        )
    }
}
