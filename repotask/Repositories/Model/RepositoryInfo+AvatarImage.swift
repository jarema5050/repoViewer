//
//  RepositoryInfo+AvatarImage.swift
//  repotask
//
//  Created by Anna Wąsowicz on 07/12/2022.
//

import Foundation
import RxSwift
import UIKit

extension RepositoryInfo {
    var avatarImage: Observable<UIImage?>? {
        if let url = self.owner.avatarUrl {
            return repositoryService.getImage(url: url)
        }
        
        return nil
    }
}
