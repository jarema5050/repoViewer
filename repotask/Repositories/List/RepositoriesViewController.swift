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
    
    var viewModel: RepositoriesViewModel!
    
    private var disposeBag = DisposeBag()
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var sortButton = BarButtonItem(item: UIBarButtonItem(title: "Sort A→Z"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.allowsSelection = true
        
        self.navigationItem.rightBarButtonItem = self.sortButton.item
        
        self.sortButton.setTitle("Random", for: .selected)
        
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        self.sortButton.isSelected
            .bind(to: self.viewModel.input.sort)
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.repositories
            .asDriver(onErrorJustReturn: [])
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
