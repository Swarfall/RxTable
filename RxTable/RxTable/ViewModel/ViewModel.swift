//
//  ViewModel.swift
//  RxTable
//
//  Created by Вячеслав on 03.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class ViewModel {
    
    var terms = Driver<[TermModel]>.of([])
    let showLoading = BehaviorRelay<Bool>(value: false)
    
    init() {
        showLoading.accept(false)
        terms = Driver.of(RequestService.getTerms())
        showLoading.accept(true)
    }
}
