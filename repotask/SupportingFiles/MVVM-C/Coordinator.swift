//
//  Coordinator.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import Foundation
import Swinject
import UIKit

protocol Coordinator: AnyObject {
    var container: Container { get }
    
    func start()
}
