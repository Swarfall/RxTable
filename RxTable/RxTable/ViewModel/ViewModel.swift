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
    
    var terms = Observable<[TermModel]>.of([])
    let showLoading = BehaviorRelay<Bool>(value: false)
    
    func getData() {
        showLoading.accept(true)
        RequestService.getTerms(completion: { [weak self] getTerms in
            self?.terms = getTerms
        })
        showLoading.accept(false)
    }
}
