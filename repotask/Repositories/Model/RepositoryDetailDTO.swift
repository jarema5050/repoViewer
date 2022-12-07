//
//  RepositoryDetailDTO.swift
//  repotask
//
//  Created by Anna Wąsowicz on 07/12/2022.
//

import Foundation

struct RepositoryDetailDTO {
    var ownerLogin: String
    var ownerDisplayName: String? //bitbucket
    var avatarImage: Observable<UIImage?>
    var ownerHtmlUrl: URL?
    var userType: String
    
    var repositoryName: String
    var isPrivate: Bool? // github
    var htmlUrl: URL? //github
    var description: String?
    var repositorySource: RepositorySource?
    
    init(repositoryInfo: RepositoryInfo) {
        self.ownerLogin = repositoryInfo.owner.login
        self.ownerDisplayName = repo
    }
    
    var avatarImage: Observable<UIImage?>? {
        if let url = self.parent.owner.avatarUrl {
        
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
