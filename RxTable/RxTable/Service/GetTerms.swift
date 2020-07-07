//
//  GetTerms.swift
//  RxTable
//
//  Created by Вячеслав on 03.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import Foundation

final class RequestService {
    static func getTerms() -> [TermModel] {
        let first = TermModel(termText: "I make a request for the opening of an account with solarisBank AG and confirm the correctness of the information provided. Should the information change, I am obliged to immediately inform SPACE and, if necessary, make relevant documents available",
                              url: nil)
        
        let second = TermModel(termText: "I agree to provide my tax residency and tax identification number within 90 days of opening my account",
                               url: nil)
        
        let third = TermModel(termText: "Taccept Space GmBH Terms & Conditions as well as General Terms & Conditions and all other conditions of solarisBank AG ",
                              url: ["https://medium.com/fantageek/rxswift-with-mvvm-e4af71413298",
                                    "https://issuu.com/nadirchine/docs/rxswift-reactive-programming-swift-",
                                    "https://stackoverflow.com/"])
        
        let fourth = TermModel(termText: "I confirm that I have read and understood the Customer Information on Data Processing, the Depositor Information Sheet and the the tax information",
                               url: ["https://medium.com/fantageek/rxswift-with-mvvm-e4af71413298",
                               "https://issuu.com/nadirchine/docs/rxswift-reactive-programming-swift-",
                               "https://stackoverflow.com/"])
        
        return [first, second, third, fourth]
    }
}
