//
//  RepositoryInfoListDTO.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 07/12/2022.
//

import Foundation
import UIKit
import RxSwift

struct RepositoryInfoListDTO {
    var parent: RepositoryInfo
    
    private var repositoryService: RepositoryService
    
    init(parent: RepositoryInfo, repositoryService: RepositoryService) {
        self.parent = parent
        self.repositoryService = repositoryService
    }
    
    lazy var avatarImage: Observable<UIImage?>? = {
        if let url = self.parent.owner.avatarUrl {
            return self.repositoryService.getImage(url: url)
        }
        
        return nil
    }()
    
    lazy var login: String? = {
        self.parent.owner.login
    }()
    
    lazy var name: String? = {
        self.parent.name
    }()
    
    lazy var sourceImage: UIImage? = {
        self.parent.repositorySource?.image
    }()
}
