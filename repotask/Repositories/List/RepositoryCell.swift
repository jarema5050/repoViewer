//
//  RepositoryCell.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import Foundation
import UIKit
import RxSwift

class RepositoryCell: UICollectionViewCell {
    static let reuseIdentifier = "RepositoryCell"
    
    @IBOutlet private var repositoryNameLabel: UILabel!
    @IBOutlet private var ownerNameLabel: UILabel!
    @IBOutlet private var repositorySourceImageView: UIImageView!
    @IBOutlet private var ownerImageView: UIImageView!
    
    private var disposeBag = DisposeBag()
    
    func set(repository: RepositoryInfoListDTO) {
        self.repositoryNameLabel.text = repository.name
        self.ownerNameLabel.text = repository.login
        self.repositorySourceImageView.image = repository.sourceImage
        
        repository.avatarImage?
            .asDriver(onErrorJustReturn: UIImage(systemName: "multiply.circle.fill"))
            .debug()
            .drive(self.ownerImageView.rx.image)
            .disposed(by: self.disposeBag)
        
    }
}
