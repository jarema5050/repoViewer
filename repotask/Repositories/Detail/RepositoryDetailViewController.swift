//
//  RepositoryDetailViewController.swift
//  repotask
//
//  Created by Anna Wąsowicz on 07/12/2022.
//

import UIKit

class RepositoryDetailViewController: UIViewController, Storyboardable {
    
    static var storyBoardName: String {
        "RepositoryDetailViewController"
    }
    
    var viewModel: RepositoryDetailViewModel!
    
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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
