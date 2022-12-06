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
    convenience init(window: UIWindow, container: Container) {
        let navigationController = UINavigationController()
        
        window.rootViewController? = navigationController
        self.init(container: container, navigationController: navigationController)
    }
    
    override func start() {
        self.bind(coordinator: RepositoriesCoordinator(container: self.container, navigationController: self.navigationController))
        
        super.start()
    }
}
