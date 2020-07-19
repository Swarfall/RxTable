//
//  BaseEntity.swift
//  RxTable
//
//  Created by Вячеслав on 17.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import Foundation

class BaseEntity {
    
    var cellType: BaseCell.Type
    
    init(cellType: BaseCell.Type) {
        self.cellType = cellType
    }
}
