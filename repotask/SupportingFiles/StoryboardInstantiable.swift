//
//  StoryboardInstantiable.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import Foundation
import UIKit

protocol Storyboardable: UIViewController {
    static var storyBoardName: String { get }
}

extension Storyboardable {
    static func instantiate(bundle: Bundle = .main) -> Self? {
        UIStoryboard(name: self.storyBoardName, bundle: bundle)
            .instantiateViewController(withIdentifier: "\(Self.self)") as? Self
    }
}
