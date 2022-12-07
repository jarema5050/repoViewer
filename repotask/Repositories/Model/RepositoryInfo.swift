//
//  RepositoryInfo.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 06/12/2022.
//

import Foundation

struct RepositoryInfoPackage: Decodable {
    var values: [RepositoryInfo]
    
    enum GeneralCodingKeys: CodingKey {
        case values
    }
}

struct RepositoryInfo: Decodable {
    enum OwnerCodingKeys: String, CodingKey {
        case login
        case nickname
        case displayName
        case avatarUrl
        case htmlUrl
        case type
        case links
    }
    
    enum BitbucketCodingKeys: String, CodingKey {
        case href
        case avatar
        case html
    }
    
    enum GeneralCodingKeys: String, CodingKey {
        case name
        case isPrivate = "private"
        case htmlUrl
        case type
        case description
        case owner
    }
    
    struct Owner: Decodable {
        var login: String
        var displayName: String? //bitbucket
        var avatarUrl: URL?
        var htmlUrl: URL?
        var type: String
    }
    
    var name: String
    var isPrivate: Bool? // github
    var htmlUrl: URL? //github
    var description: String?
    var owner: Owner
    var repositorySource: RepositorySource?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GeneralCodingKeys.self)
                
        self.name = try container.decode(String.self, forKey: .name)
        self.isPrivate = try? container.decode(Bool.self, forKey: .isPrivate)
        self.htmlUrl = try? container.decode(URL.self, forKey: .htmlUrl)
        self.description = try? container.decode(String.self, forKey: .description)
        
        let ownerContainer = try container.nestedContainer(keyedBy: OwnerCodingKeys.self, forKey: .owner)
        let ownerLoginGithub = try? ownerContainer.decode(String.self, forKey: .login)
        let ownerLoginBitbucket = try? ownerContainer.decode(String.self, forKey: .nickname)
        let ownerDisplayName = try? ownerContainer.decode(String.self, forKey: .displayName)
        let ownerAvatarUrl = try? ownerContainer.decode(URL.self, forKey: .avatarUrl)
        let ownerHtmlUrl = try? ownerContainer.decode(URL.self, forKey: .htmlUrl)
        let ownerType = try ownerContainer.decode(String.self, forKey: .type)
        
        let linksContainer = try? ownerContainer.nestedContainer(keyedBy: BitbucketCodingKeys.self, forKey: .links)
        
        let avatarContainer = try? linksContainer?.nestedContainer(keyedBy: BitbucketCodingKeys.self, forKey: BitbucketCodingKeys.avatar)
        let ownerAvatarUrlBitbucket = try? avatarContainer?.decode(URL.self, forKey: .href)
        
        let htmlContainer = try? linksContainer?.nestedContainer(keyedBy: BitbucketCodingKeys.self, forKey: BitbucketCodingKeys.html)
        let ownerHtmlUrlBitbucket = try? htmlContainer?.decode(URL.self, forKey: .href)
        
        self.owner = Owner(
            login: ownerLoginGithub ?? ownerLoginBitbucket ?? "",
            displayName: ownerDisplayName,
            avatarUrl: ownerAvatarUrl ?? ownerAvatarUrlBitbucket,
            htmlUrl: ownerHtmlUrl ?? ownerHtmlUrlBitbucket,
            type: ownerType
        )
    }
}
