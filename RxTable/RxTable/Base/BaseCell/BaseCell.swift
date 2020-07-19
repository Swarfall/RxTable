//
//  BaseCell.swift
//  RxTable
//
//  Created by Вячеслав on 17.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import UIKit

protocol BaseCellDelegate: class {
    func update(model: BaseEntity)
}

class BaseCell: UITableViewCell, BaseCellDelegate {
    func update(model: BaseEntity) { }
}
