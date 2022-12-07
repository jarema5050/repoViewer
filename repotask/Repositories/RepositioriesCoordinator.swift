//
//  RepositioriesCoordinator.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import Swinject
import UIKit

final class RepositoriesCoordinator: NavigationCoordinator {
    
    override func start() {
        let vc = container.resolve(RepositoriesViewController.self)!
        navigationController.pushViewController(vc, animated: true)
//        vc.viewModel.output.selected
//            .subscribe(onNext: { selected in
//                
//            })
        super.start()
    }
    
    func presentList() {
        
        
//        navigationController.pushViewController(vc, animated: true)
    }
//
//    func presentDetail(detail: RepositoryInfo) {
//        let vc =
//    }
}
