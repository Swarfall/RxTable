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
    
    init(country: String, code: String) {
        self.country = country
        self.code = code
    }
}

final class StateEntity {
    let nameState: String
    
    init(nameState: String) {
        self.nameState = nameState
    }
}
