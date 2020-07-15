//
//  RequestService.swift
//  RxTable
//
//  Created by Вячеслав on 15.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import Foundation

final class RequestService {
    static func fetchAdress(completion: @escaping([CountryModel]) -> Void) {
        var adresses = [CountryModel]()
        
        let ge = CountryModel(country: "Germany", state: ["Munich", "Dortmund", "Bayern", "Livercusen"])
        let ua = CountryModel(country: "Ukraine", state: ["Kyiv", "Volyn'", "Odessa", "Lviv"])
        
        adresses.append(ge)
        adresses.append(ua)
        
        completion(adresses)
    }
}
