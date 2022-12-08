//
//  RepositioriesCoordinator.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import Swinject
import UIKit
import RxSwift
import SafariServices

final class RepositoriesCoordinator: NavigationCoordinator {
    var disposeBag = DisposeBag()
    
    override func start() {
        self.navigationController.navigationBar.tintColor = .white
        self.navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController.navigationBar.isTranslucent = true
        self.presentList()
        
        super.start()
    }
    
    private func presentList() {
        guard let viewController = self.container.resolve(RepositoriesViewController.self) else {
            return
        }
        
        self.navigationController.pushViewController(viewController, animated: true)
        _ = viewController.view
        self.bind(selectedRepository: viewController.selectedRepository)
    }

    private func bind(selectedRepository: Observable<RepositoryInfo>) {
        selectedRepository
            .subscribe(onNext: { [unowned self] repository in
                if self.navigationController.viewControllers.first is RepositoriesViewController {
                    self.presentDetail(detail: repository)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func presentDetail(detail: RepositoryInfo) {
        let viewModel = self.container.resolve(RepositoryDetailViewModel.self, argument: detail)
        
        guard let viewController = self.container.resolve(RepositoryDetailViewController.self, argument: viewModel) else {
            return
        }
        
        _ = viewController.view
        
        viewController.openURL
            .subscribe(onNext: { [unowned self] url in
                self.presentLink(url: url)
            })
            .disposed(by: self.disposeBag)
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    private func presentLink(url: URL) {
        guard let viewController = self.container.resolve(SFSafariViewController.self, argument: url) else {
            return
        }
        
        self.navigationController.present(viewController, animated: true)
    }
}
