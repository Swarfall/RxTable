//
//  AddressModel.swift
//  RxTable
//
//  Created by Вячеслав on 15.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import Foundation

final class CountryEntity {
    let country: String
    let code: String
    let state: [StateEntity]?
    
    init(country: String, code: String, state: [StateEntity]?) {
        self.country = country
        self.code = code
        self.state = state
    }
}

final class StateEntity {
    let nameState: String
    
    init(nameState: String) {
        self.nameState = nameState
    }
}
