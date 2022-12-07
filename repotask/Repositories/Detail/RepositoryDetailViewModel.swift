//
//  RepositoryDetailViewModel.swift
//  repotask
//
//  Created by Anna Wąsowicz on 07/12/2022.
//

import Foundation
import RxSwift

class RepositoryDetailViewModel: ViewModel {
    var input: Input
    
    var output: Output
    
    struct Input { }
    
    struct Output {
        //var repository: Observable<RepositoryInfo>
    }
    
    init() {
        self.input = Input()
        self.output = Output()
    }
}
