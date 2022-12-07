//
//  RepositoryDetailViewController.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 07/12/2022.
//

import UIKit
import RxSwift

class RepositoryDetailViewController: UIViewController, Storyboardable {
    
    static var storyBoardName: String {
        return "Repositories"
    }
    
    var viewModel: RepositoryDetailViewModel!
    
    var disposeBag = DisposeBag()
    
    @IBOutlet private weak var repositoryTypeImageView: UIImageView!
    
    @IBOutlet private weak var isPrivateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var goToSourceButton: UIButton!
    
    @IBOutlet private weak var ownerAvatarImageView: UIImageView!
    @IBOutlet private weak var ownerLoginLabel: UILabel!
    @IBOutlet private weak var ownerDisplayNameLabel: UILabel!
    @IBOutlet private weak var ownerTypeLabel: UILabel!
    
    @IBOutlet private weak var goToProfileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViewModel()
    }
    
    private func bindViewModel() {
        self.viewModel.output.avatarImage
            .asDriver(onErrorJustReturn: UIImage(systemName: "multiply.circle.fill"))
            .drive(self.ownerAvatarImageView.rx.image)
            .disposed(by: self.disposeBag)
        
        if let isPrivate = self.viewModel.repository.isPrivate {
            self.isPrivateLabel.attributedText = self.labeled(label: "is private", text: isPrivate ? "PRIVATE" : "PUBLIC")
        } else {
            self.isPrivateLabel.attributedText = self.labeled(label: "is private", text: "NOT SPECIFIED")
        }
        
        self.descriptionLabel.attributedText = self.labeled(label: "description", text: self.viewModel.repository.description ?? "NOT SPECIFIED")
        self.ownerLoginLabel.attributedText = self.labeled(label: "login", text: self.viewModel.repository.owner.login)
        self.ownerDisplayNameLabel.attributedText = self.labeled(label: "display name", text: self.viewModel.repository.owner.displayName ?? "NOT SPECIFIED")
        self.ownerTypeLabel.attributedText = self.labeled(label: "user type", text: self.viewModel.repository.owner.type)
        
        self.repositoryTypeImageView.image = self.viewModel.repository.repositorySource?.image
        
        self.title = self.viewModel.repository.name
    }
    
    private func labeled(label: String, text: String) -> NSAttributedString {
        let firstAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12, weight: .medium),
            .foregroundColor: UIColor.darkGray
        ]
        
        let secondAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]

        let firstString = NSMutableAttributedString(string: label, attributes: firstAttributes)
        let secondString = NSAttributedString(string: " \(text)", attributes: secondAttributes)

        firstString.append(secondString)
        
        return firstString
    }
}
