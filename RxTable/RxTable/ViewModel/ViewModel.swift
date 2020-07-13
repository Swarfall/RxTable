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
    
    init() {
        showLoading.accept(true)
    }
    
    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showLoading.accept(true)
            self.terms = RequestService.getTerms()
            self.showLoading.accept(false)
        }
    }
}
