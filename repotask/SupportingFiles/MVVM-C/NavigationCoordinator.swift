//
//  NavigationCoordinator.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import Foundation
import Swinject
import UIKit

class NavigationCoordinator: NavigableCoordinator {
    let container: Container
    let navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    required init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }
    
    func bind(coordinator: any Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func start() {}
}

