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
    
    var terms: Observable<[TermModel]> {
        return self.termsProperty.asObservable()
    }
    
    var loadProgress: Observable<Bool> {
        return self.loadProperty.asObservable()
    }
    
    // MARK: - Private properties
    private let termsProperty = BehaviorRelay<[TermModel]>(value: [])
    private let loadProperty = BehaviorRelay<Bool>(value: false)
    
    func fetchTerms() {
        loadProperty.accept(true)
        RequestService.getTerms { [weak self] terms in
            self?.termsProperty.accept(terms)
            self?.loadProperty.accept(false)
        }
    }
}
