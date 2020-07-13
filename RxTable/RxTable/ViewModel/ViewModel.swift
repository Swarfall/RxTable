//
//  ViewModel.swift
//  RxTable
//
//  Created by Вячеслав on 03.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class ViewModel {
    
    let terms = PublishSubject<[TermModel]>()
    let showLoading = BehaviorRelay<Bool>(value: true)
    
    func getData() {
        showLoading.accept(false)
        RequestService.getTerms(completion: { [weak self] getTerms in
            self?.terms.onNext(getTerms)
            self?.terms.onCompleted()
            self?.showLoading.accept(true)
        })
    }
}
