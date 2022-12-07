//
//  AppCoordinator.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import Foundation
import Swinject
import UIKit

final class AppCoordinator: NavigationCoordinator {
    override func start() {
        self.bind(coordinator: RepositoriesCoordinator(container: self.container, navigationController: self.navigationController))
        
        super.start()
    }
}
