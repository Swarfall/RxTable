//
//  ViewModel.swift
//  RxTable
//
//  Created by Вячеслав on 15.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import RxCocoa
import RxSwift

protocol ViewModelType {
    var input: ViewModelInput { get }
    var output: ViewModelOutput { get }
}

protocol ViewModelInput {
    var city: BehaviorRelay<String> { get }
    var country: BehaviorRelay<String> { get }
    var state: BehaviorRelay<String> { get }
}

protocol ViewModelOutput {
    var cityString: Observable<String> { get }
    var countryString: Observable<String> { get }
    var stateString: Observable<String> { get }
    var isValid: Observable<Bool> { get }
}

final class ViewModel: ViewModelInput, ViewModelOutput {
    var city = BehaviorRelay<String>(value: "")
    var country = BehaviorRelay<String>(value: "")
    var state = BehaviorRelay<String>(value: "")
    
    var cityString: Observable<String> {
        return city.asObservable()
    }
    var countryString: Observable<String> {
        return country.asObservable()
    }
    var stateString: Observable<String> {
        return state.asObservable()
    }
    var isValid: Observable<Bool>
    
    init(continueButton: Observable<Void>) {
       
        let cityValid = city
        .distinctUntilChanged()
        .map { $0.count > 0 }
        
        let countryValid = country
        .distinctUntilChanged()
        .map { $0.count > 0 }
        
        let stateValid = state
        .distinctUntilChanged()
        .map { $0.count > 0 }
        
        isValid = Observable.combineLatest(cityValid, countryValid, stateValid) { $0 && $1 && $2 }
        
        isValid = continueButton
        .withLatestFrom(isValid)
    }
}

extension ViewModel: ViewModelType {
    var input: ViewModelInput {
        return self
    }
    
    var output: ViewModelOutput {
        return self
    }
}
