//
//  Repository.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import Foundation
import UIKit

struct Repository {
    let name: String
    let owner: Owner
    let details: RepositoryDetails
}

struct RepositoryDetails {}

struct Owner {
    let userName: String
    let userAvatar: UIImage
}
