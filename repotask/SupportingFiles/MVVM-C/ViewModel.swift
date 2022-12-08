//
//  ViewModel.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 05/12/2022.
//

import Foundation

protocol ViewModel {
    
    associatedtype Input
    associatedtype Output
    
    var input: Input { get set }
    var output: Output { get set }
}
