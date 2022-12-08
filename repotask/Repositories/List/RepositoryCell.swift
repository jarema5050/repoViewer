//
//  RepositoryCell.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class RepositoryCell: UICollectionViewCell {
    static let reuseIdentifier = "RepositoryCell"
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.isSelected = false
            }
        }
    }
    
    @IBOutlet private var repositoryNameLabel: UILabel!
    @IBOutlet private var ownerNameLabel: UILabel!
    @IBOutlet private var repositorySourceImageView: UIImageView!
    @IBOutlet private var ownerImageView: UIImageView!
    
    private var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        self.disposeBag = DisposeBag()
    }
    
    func set(repository: RepositoryInfoListDTO) {
        var repository = repository
        
        self.repositoryNameLabel.text = repository.name
        self.ownerNameLabel.text = repository.login
        self.repositorySourceImageView.image = repository.sourceImage
        
        repository.avatarImage?
            .asDriver(onErrorJustReturn: UIImage(systemName: "multiply.circle.fill"))
            .drive(self.ownerImageView.rx.image)
            .disposed(by: self.disposeBag)
        
    }
}
