//
//  TermModel.swift
//  RxTable
//
//  Created by Вячеслав on 03.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import Foundation

final class TermModel {
    let termText: String
    let url: [String]?
    
    init(termText: String, url: [String]?) {
        self.termText = termText
        self.url = url
    }
}
