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
}

protocol MenuViewModelOutput {
    var countries: Observable<[CountryEntity]> { get }
    var gerStates: Observable<[StateEntity]> { get }
}

protocol MenuViewModelType {
    var input: MenuViewModelInput { get }
    var output: MenuViewModelOutput { get }
}

final class MenuViewModel: MenuViewModelInput, MenuViewModelOutput {
    
    // MARK: - Public properties
    var viewModel = ViewModel()
    
    var countries: Observable<[CountryEntity]> {
        return self.countriesProperty.asObservable()
    }
    
    var gerStates: Observable<[StateEntity]> {
        return self.gerStatesProperty.asObservable()
    }
    
    var countriesProperty = BehaviorRelay<[CountryEntity]>(value: [])
    var gerStatesProperty = BehaviorRelay<[StateEntity]>(value: [])
    
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
