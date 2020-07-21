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

protocol AddressViewModelType {
    var input: AddressViewModelInput { get }
    var output: AddressViewModelOutput { get }
}

protocol AddressViewModelInput {
    var city: BehaviorRelay<String> { get }
    var country: BehaviorRelay<String> { get }
    var state: BehaviorRelay<String> { get }
    var code: BehaviorRelay<String> { get }
}

protocol AddressViewModelOutput: ValidationFields {
    var cityString: Observable<String> { get }
    var countryString: Observable<String> { get }
    var stateString: Observable<String> { get }
    var codeString: Observable<String> { get }
    var menuViewModel: MenuViewModel { get }
}

final class AddressViewModel: AddressViewModelInput, AddressViewModelOutput {
    
    var menuViewModel = MenuViewModel()
    
    var city = BehaviorRelay<String>(value: "")
    var country = BehaviorRelay<String>(value: "")
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

extension AddressViewModel: AddressViewModelType {
    var input: AddressViewModelInput {
        return self
    }
    
    var output: AddressViewModelOutput {
        return self
    }
}
