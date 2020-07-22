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
    var stateProperty: BehaviorRelay<String> { get }
    var entityProperty: BehaviorRelay<CountryEntity?> { get }
    func fetchCountries()
    func fetchGerStates()
}

protocol MenuViewModelOutput {
    var countries: Observable<[CountryEntity]> { get }
    var gerStates: Observable<[StateEntity]> { get }
    var state: Observable<String> { get }
    var entity: Observable<CountryEntity?> { get }
}

protocol MenuViewModelType {
    var input: MenuViewModelInput { get }
    var output: MenuViewModelOutput { get }
}

final class MenuViewModel: MenuViewModelInput, MenuViewModelOutput {
    
    var countries: Observable<[CountryEntity]> {
        return self.countriesProperty.asObservable()
    }
    var gerStates: Observable<[StateEntity]> {
        return self.gerStatesProperty.asObservable()
    }
    var entity: Observable<CountryEntity?> {
        return entityProperty.asObservable()
    }
    var state: Observable<String> {
        return stateProperty.asObservable()
    }
    
    var countriesProperty = BehaviorRelay<[CountryEntity]>(value: [])
    var gerStatesProperty = BehaviorRelay<[StateEntity]>(value: [])
    var entityProperty = BehaviorRelay<CountryEntity?>(value: nil)
    var stateProperty = BehaviorRelay<String>(value: "")
    
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
