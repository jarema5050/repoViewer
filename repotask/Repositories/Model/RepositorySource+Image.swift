//
//  RepositorySource+Image.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 07/12/2022.
//

import Foundation
import UIKit

extension RepositorySource {
    var image: UIImage? {
        switch self {
        case .bitbucket:
            return UIImage(named: "bitbucket")
        case .github:
            return UIImage(named: "github")
        }
    }
}
