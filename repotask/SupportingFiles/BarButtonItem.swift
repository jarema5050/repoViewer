//
//  BarButtonItem.swift
//  repotask
//
//  Created by Jędrzej Sokołowski on 07/12/2022.
//

import UIKit
import RxSwift

class BarButtonItem {
    let item: UIBarButtonItem
    var isSelected: Observable<Bool>
    
    private var selected = false
    private var disposeBag = DisposeBag()
    private var titleDict = [UIControl.State: String]()
    
    init(item: UIBarButtonItem) {
        self.titleDict[.normal] = item.title
        
        let isSelectedSubject = PublishSubject<Bool>()
        
        self.item = item
        self.isSelected = isSelectedSubject
        
        let selected = item.rx.tap
            .map { [unowned self] in !self.selected }
            .share(replay: 1)
        
        selected
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [unowned self] selected in
                if selected, let selectedElement = titleDict.first(where: { key, _ -> Bool in key == .selected }) {
                    self.item.title = selectedElement.value
                } else if let normalElement = titleDict.first(where: { key, _ -> Bool in key == .normal }) {
                    self.item.title = normalElement.value
                }
                
                self.selected = selected
            })
            .disposed(by: self.disposeBag)
        
        selected
            .bind(to: isSelectedSubject)
            .disposed(by: self.disposeBag)
    }
    
    func setTitle(_ title: String, for state: UIControl.State) {
        self.titleDict[state] = title
    }
}

extension UIControl.State: Hashable {}
