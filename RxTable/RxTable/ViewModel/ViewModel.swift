//
//  ViewModel.swift
//  RxTable
//
//  Created by Вячеслав on 15.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import RxCocoa
import RxSwift

protocol ValidationFields {
    func checkFieldsFilling() -> String
}

protocol ViewModelType {
    var input: ViewModelInput { get }
    var output: ViewModelOutput { get }
}

protocol ViewModelInput {
    var city: BehaviorRelay<String> { get }
    var country: BehaviorRelay<String> { get }
    var state: BehaviorRelay<String> { get }
    var code: BehaviorRelay<String> { get }
}

protocol ViewModelOutput: ValidationFields {
    var cityString: Observable<String> { get }
    var countryString: Observable<String> { get }
    var stateString: Observable<String> { get }
    var codeString: Observable<String> { get }
}

final class ViewModel: ViewModelInput, ViewModelOutput {
    var city = BehaviorRelay<String>(value: "")
    var country = BehaviorRelay<String>(value: "1")
    var state = BehaviorRelay<String>(value: "")
    var code = BehaviorRelay<String>(value: "")
    
    var cityString: Observable<String> {
        return city.asObservable()
    }
    var countryString: Observable<String> {
        return country.asObservable()
    }
    var stateString: Observable<String> {
        return state.asObservable()
    }
    var codeString: Observable<String> {
        return code.asObservable()
    }
    
    func checkFieldsFilling() -> String {
        if city.value.isEmpty {
            return "Enter City"
        }
        if country.value.isEmpty {
            return "Enter Country"
        }
        if state.value.isEmpty {
            return "Enter State"
        }
        return "Code: \(code.value), Country: \(country.value)"
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
