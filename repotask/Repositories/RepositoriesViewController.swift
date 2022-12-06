//
//  ViewController.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import UIKit

class RepositoriesViewController: UIViewController, Storyboardable {
    static var storyBoardName: String {
        return "Repositories"
    }
    
    var viewModel: RepositoriesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}



