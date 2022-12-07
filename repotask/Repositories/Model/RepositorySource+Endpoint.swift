//
//  RepositorySource+Endpoint.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 06/12/2022.
//

import Foundation

extension RepositorySource {
    var endpoint: URL? {
        switch self {
        case .github: return URL(string: "https://api.github.com/repositories")
        case .bitbucket: return URL(string: "https://api.bitbucket.org/2.0/repositories?fields=values.name,values.owner,values.description")
        }
    }
}
