//
//  RepositoryInfoListDTO.swift
//  repotask
//
//  Created by Anna Wąsowicz on 07/12/2022.
//

import Foundation
import UIKit
import RxSwift

struct RepositoryInfoListDTO {
    private var parent: RepositoryInfo
    
    private var repositoryService: RepositoryService
    
    init(parent: RepositoryInfo, repositoryService: RepositoryService) {
        self.parent = parent
        self.repositoryService = repositoryService
    }
    
    var avatarImage: Observable<UIImage?>? {
        if let url = self.parent.owner.avatarUrl {
            return repositoryService.getImage(url: url)
        }
        
        return nil
    }
    
    var login: String? {
        self.parent.owner.login
    }
    
    var name: String? {
        self.parent.name
    }
    
    var sourceImage: UIImage? {
        self.parent.repositorySource?.image
    }
}

fileprivate extension RepositorySource {
    var image: UIImage? {
        switch self {
        case .bitbucket:
            return UIImage(named: "bitbucket")
        case .github:
            return UIImage(named: "github")
        }
    }
}
