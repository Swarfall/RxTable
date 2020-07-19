//
//  RequestService.swift
//  RxTable
//
//  Created by Вячеслав on 15.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import Foundation
import UIKit

final class RequestService {
    
    static func fetchCountries(completion: @escaping([CountryEntity]) -> Void) {
        let ger = CountryEntity(country: "Germany", code: "GER", image: UIImage(named: "ger") ?? UIImage())
        let ukr = CountryEntity(country: "Ukraine", code: "UKR", image: UIImage(named: "ukr") ?? UIImage())
        completion([ger, ukr])
    }
    
    static func fetchStates(completion: @escaping([StateEntity]) -> Void) {
        let munich = StateEntity(nameState: "Munich")
        let dortmund = StateEntity(nameState: "Dortmund")
        let bayern = StateEntity(nameState: "Bayern")
        let livercusen = StateEntity(nameState: "Livercusen")
        completion([munich, dortmund, bayern, livercusen])
    }
}
