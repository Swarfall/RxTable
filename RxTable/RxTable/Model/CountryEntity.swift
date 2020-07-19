//
//  AddressModel.swift
//  RxTable
//
//  Created by Вячеслав on 15.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import UIKit

final class CountryEntity: BaseEntity {
    let country: String
    let code: String
    let image: UIImage
    
    init(country: String, code: String, image: UIImage, cellType: BaseCell.Type = MenuCell.self) {
        self.country = country
        self.code = code
        self.image = image
        super.init(cellType: cellType)
    }
}

final class StateEntity: BaseEntity {
    let nameState: String
    
    init(nameState: String, cellType: BaseCell.Type = MenuCell.self) {
        self.nameState = nameState
        super.init(cellType: cellType)
    }
}
