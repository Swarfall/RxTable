//
//  GetTerms.swift
//  RxTable
//
//  Created by Вячеслав on 03.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

final class RequestService {
    static func getTerms() -> Observable<[TermModel]> {
        let first = TermModel(agreementText: "I make a request for the opening of an account with solarisBank AG and confirm the correctness of the information provided. Should the information change, I am obliged to immediately inform SPACE and, if necessary, make relevant documents available")
        
        let second = TermModel(agreementText: "I act only in my own economic interest and not on the initiative of a third party")
        
        let third = TermModel(agreementText: "I confirm that I have read and understood the <a href=\"https://www.solarisbank.com/content/partner/Kundeninformation_zur_Datenverarbeitung_englisch_v1.2.pdf\">Customer Information on Data Processing</a>, the <a href=\"https://www.solarisbank.com/content/partner/Informationen_zur_Einlagensicherung_v1.2_englisch.pdf\">Depositor Information Sheet</a>, and the <a href=\"https://www.solarisbank.com/content/partner/automatischer-informationsaustausch-zur-kirchensteuer_v1.1-englisch.pdf\">tax information</a>")
        
        let fourth = TermModel(agreementText: "I accept Space GmBH <a href=\"https://space.ge/\">Terms & Conditions</a> as well as <a href=\"https://www.solarisbank.com/content/partner/allgemeine_geschaeftsbedingungen_englisch_v1.3.pdf\">General Terms & Conditions</a> and <a href=\"https://www.solarisbank.com/en/customer-information/\">all other conditions</a> of solarisBank AG")
        
        return Observable.of([first, second, fourth, third])
    }
}
