//
//  Repository.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import UIKit

struct Repository {
    
    enum Source {
        case github
        case bitbucket
    }
    
    struct RepositoryDetails {}

    struct Owner {
        let userName: String
        let userAvatar: UIImage
    }
    
    let name: String
    let owner: Owner
    let details: RepositoryDetails
    let source: Source
}
