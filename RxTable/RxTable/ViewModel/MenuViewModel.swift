//
//  MenuViewModel.swift
//  RxTable
//
//  Created by Вячеслав on 17.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import RxCocoa
import RxSwift

protocol MenuViewModelInput {
    var countriesProperty: BehaviorRelay<[CountryEntity]> { get }
    var gerStatesProperty: BehaviorRelay<[StateEntity]> { get }
    func fetchCountries()
    func fetchGerStates()
    var countryProperty: BehaviorRelay<String> { get }
    var stateProperty: BehaviorRelay<String> { get }
    var codeProperty: BehaviorRelay<String> { get }
//    func countryCallback (@escaping callback:(String, String) -> Void)
    //func fetchCountries(completion: @escaping([CountryEntity]) -> Void)
    var countryCallback: ((_ country: String, _ code: String) -> Void)? { get }
}

protocol MenuViewModelOutput {
    var countries: Observable<[CountryEntity]> { get }
    var gerStates: Observable<[StateEntity]> { get }
    var country: Observable<String> { get }
    var state: Observable<String> { get }
    var code: Observable<String> { get }
}

protocol MenuViewModelType {
    var input: MenuViewModelInput { get }
    var output: MenuViewModelOutput { get }
}

final class MenuViewModel: MenuViewModelInput, MenuViewModelOutput {
    
    var countryCallback: ((String, String) -> Void)?
    
    var countries: Observable<[CountryEntity]> {
        return self.countriesProperty.asObservable()
    }
    
    var gerStates: Observable<[StateEntity]> {
        return self.gerStatesProperty.asObservable()
    }
    var country: Observable<String> {
        return countryProperty.asObservable()
    }
    var state: Observable<String> {
        return stateProperty.asObservable()
    }
    var code: Observable<String> {
        return codeProperty.asObservable()
    }
    
    var countriesProperty = BehaviorRelay<[CountryEntity]>(value: [])
    var gerStatesProperty = BehaviorRelay<[StateEntity]>(value: [])
    var countryProperty = BehaviorRelay<String>(value: "")
    var stateProperty = BehaviorRelay<String>(value: "")
    var codeProperty = BehaviorRelay<String>(value: "")
    
    // MARK: - Public methods
    func fetchCountries() {
        RequestService.fetchCountries { [weak self] countries in
            self?.countriesProperty.accept(countries)
        }
    }
    
    func fetchGerStates() {
        RequestService.fetchStates { [weak self] states in
            self?.gerStatesProperty.accept(states)
        }
    }
}

extension MenuViewModel: MenuViewModelType {
    var input: MenuViewModelInput {
        return self
    }
    
    var output: MenuViewModelOutput {
        return self
    }
}
