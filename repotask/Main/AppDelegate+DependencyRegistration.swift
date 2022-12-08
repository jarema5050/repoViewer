//
//  AppDelegate+DependencyRegistration.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 06/12/2022.
//

import Foundation
import Swinject
import SafariServices

extension AppDelegate {
    func setupDependencies() {
        self.container.register(HTTPService.self) { _ in return HTTPService() }
        
        self.container.register(RepositoryService.self) { resolver in
            RepositoryService(httpService: resolver.resolve(HTTPService.self).unsafelyUnwrapped)
        }
        
        self.container.register(RepositoriesViewModel.self) { resolver in
            let repositoryService = resolver.resolve(RepositoryService.self).unsafelyUnwrapped
            return RepositoriesViewModel(repositoryService: repositoryService)
        }
        
        self.container.register(RepositoryDetailViewModel.self) { resolver, repository in
            let repositoryService = resolver.resolve(RepositoryService.self).unsafelyUnwrapped
            return RepositoryDetailViewModel(repositoryService: repositoryService, repository: repository)
        }
        
        self.container.register(SFSafariViewController.self) { _, url in
            return SFSafariViewController(url: url)
        }
        
        self.container.register(RepositoriesViewController.self) { resolver in
            let viewController = RepositoriesViewController.self.instantiate().unsafelyUnwrapped
            
            viewController.viewModel = resolver.resolve(RepositoriesViewModel.self)
            return viewController
        }
        
        self.container.register(RepositoryDetailViewController.self) { resolver, viewModel in
            let viewController = RepositoryDetailViewController.self.instantiate().unsafelyUnwrapped
            
            viewController.viewModel = viewModel
            return viewController
        }
    }
}
