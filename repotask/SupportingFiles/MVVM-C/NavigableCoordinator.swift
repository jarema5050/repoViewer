//
//  NavigableCoordinator.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import Foundation
import UIKit
import Swinject

protocol NavigableCoordinator: Coordinator {
    init(container: Container, navigationController: UINavigationController)
}
