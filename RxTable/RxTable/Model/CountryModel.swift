//
//  AddressModel.swift
//  RxTable
//
//  Created by Вячеслав on 15.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import Foundation

final class CountryModel {
    let country: String
    let state: [String]
    
    init(country: String, state: [String]) {
        self.country = country
        self.state = state
    }
}
