//
//  TermModel.swift
//  RxTable
//
//  Created by Вячеслав on 03.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import Foundation

final class TermModel {
    var isSelect: Bool
    let termText: String
    let url: [String]?
    
    init(isSelect: Bool = false, termText: String, url: [String]?) {
        self.isSelect = isSelect
        self.termText = termText
        self.url = url
    }
}
