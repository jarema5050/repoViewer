//
//  AppDelegate+DependencyRegistration.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 06/12/2022.
//

import Foundation
import Swinject

extension AppDelegate {
    func setupDependencies() {
        self.container.register(HTTPService.self) { _ in return HTTPService() }
        
        self.container.register(RepositoryService.self) { resolver in
            RepositoryService(httpService: resolver.resolve(HTTPService.self)!)
        }
        
        self.container.register(RepositoriesViewModel.self) { resolver in
            let repositoryService = resolver.resolve(RepositoryService.self)!
            return RepositoriesViewModel(repositoryService: repositoryService)
        }
        
        self.container.register(RepositoryDetailViewModel.self) { resolver, repository in
            let repositoryService = resolver.resolve(RepositoryService.self)!
            return RepositoryDetailViewModel(repositoryService: repositoryService, repository: repository)
        }
        
        self.container.register(RepositoriesViewController.self) { resolver in
            let viewController = RepositoriesViewController.self.instantiate()!
            
            viewController.viewModel = resolver.resolve(RepositoriesViewModel.self)
            return viewController
        }
        
        self.container.register(RepositoryDetailViewController.self) { resolver, viewModel in
           let viewController = RepositoryDetailViewController.self.instantiate()!
            
            viewController.viewModel = viewModel
            
            return viewController
        }
    }
}
