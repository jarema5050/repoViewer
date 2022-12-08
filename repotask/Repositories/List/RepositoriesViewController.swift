//
//  ViewController.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class RepositoriesViewController: UIViewController, UICollectionViewDelegate, Storyboardable {
    
    static var storyBoardName: String {
        return "Repositories"
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var errorOverlay: UIView!
    
    @IBOutlet private weak var errorDescriptionLabel: UILabel!
    @IBOutlet private weak var refreshButton: UIButton!
    
    var viewModel: RepositoriesViewModel!
    
    private var disposeBag = DisposeBag()
    private let sortButton = BarButtonItem(item: UIBarButtonItem(title: "Sort A→Z"))
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.allowsSelection = true
        self.collectionView.refreshControl = self.refreshControl
        
        self.navigationItem.rightBarButtonItem = self.sortButton.item
        
        self.sortButton.setTitle("Random", for: .selected)
        
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        Observable.merge(
            self.refreshControl.rx.controlEvent(.valueChanged).asObservable(),
            self.refreshButton.rx.tap.asObservable()
        )
            .bind(to: self.viewModel.input.refresh)
            .disposed(by: self.disposeBag)
        
        self.sortButton.isSelected
            .bind(to: self.viewModel.input.sort)
            .disposed(by: self.disposeBag)
        
        let repositories = self.viewModel.output.repositories
            .share(replay: 1)
        
        repositories
            .map { _ in false }
            .asDriver(onErrorDriveWith: .empty())
            .drive(self.refreshControl.rx.isRefreshing)
            .disposed(by: self.disposeBag)
        
        
        repositories
            .asDriver(onErrorDriveWith: .empty())
            .drive(self.collectionView.rx.items) { (collectionView: UICollectionView, index: Int, repository: RepositoryInfoListDTO) in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepositoryCell.reuseIdentifier, for: IndexPath(index: index))
                
                (cell as? RepositoryCell)?.set(repository: repository)
                
                return cell
            }
            .disposed(by: self.disposeBag)
    }
}

extension RepositoriesViewController {
    var selectedRepository: Observable<RepositoryInfo> {
        self.collectionView.rx.modelSelected(RepositoryInfoListDTO.self)
            .map(\.parent)
    }
}
