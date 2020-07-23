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
    var state: BehaviorRelay<String> { get }
    var entity: BehaviorRelay<CountryEntity?> { get }
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
    var state = BehaviorRelay<String>(value: "")
    var entity = BehaviorRelay<CountryEntity?>(value: nil)
    
    var cityString: Observable<String> {
        return city.asObservable()
    }
    var stateString: Observable<String> {
        return state.asObservable()
    }
    var codeString: Observable<String> {
        return entity.compactMap { $0 }.map { $0.code }
    }
    var countryString: Observable<String> {
        return entity.compactMap { $0 }.map {$0.country}
    }
    
    func checkFieldsFilling() -> String {
        if city.value.isEmpty {
            return "Enter City"
        }
        if let counrty = entity.value?.country, counrty.isEmpty {
            return "Enter Country"
        }
        if state.value.isEmpty {
            return "Enter State"
        }
        return "Code: \(entity.value?.code ?? "no code"), Country: \(entity.value?.country ?? "no country")"
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
