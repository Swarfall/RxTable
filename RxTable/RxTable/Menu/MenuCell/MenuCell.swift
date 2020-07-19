//
//  MenuCell.swift
//  RxTable
//
//  Created by Вячеслав on 17.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import UIKit

protocol MenuCellDelegate {
    func selectAdress()
}

class MenuCell: BaseCell {

    @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    static let identifier = "MenuCell"
    
    // TODO: - пока оставляю для алерта на главном экране. Возможно, не пригодиться эти свойства
    var stateCode = ""
    var country = ""
    
    var selectAdress: SelectField!
    var delegate: MenuCellDelegate?
    
    override func update(model: BaseEntity?) {
        if selectAdress == SelectField.country {
            guard let entity = model as? CountryEntity else { return }
            flagImageView.isHidden = false
            flagImageView.image = entity.image
            nameLabel.text = entity.country
            stateCode = entity.code
            country = entity.country
        } else if selectAdress == SelectField.state {
            guard let entity = model as? StateEntity else { return }
            flagImageView.isHidden = true
            nameLabel.text = entity.nameState
        }
    }
}
