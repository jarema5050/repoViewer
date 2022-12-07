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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.output.repositories
            .asDriver(onErrorJustReturn: [])
            .drive(self.collectionView.rx.items) { (collectionView: UICollectionView, index: Int, repository: RepositoryInfoListDTO) in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepositoryCell.reuseIdentifier, for: IndexPath(index: index))
                
                (cell as? RepositoryCell)?.set(repository: repository)
                
                return cell
            }
            .disposed(by: self.disposeBag)
    }
}



