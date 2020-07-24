//
//  MenuCell.swift
//  RxTable
//
//  Created by Вячеслав on 17.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {

    @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    static let identifier = "MenuCell"
    
    var entity: BaseEntity?
    var selectAdress: SelectField!
    
    override func update(model: BaseEntity?) {
        if selectAdress == SelectField.country {
            
            guard let entity = model as? CountryEntity else { return }
            self.entity = entity
             
            flagImageView.isHidden = false
            flagImageView.image = entity.image
            nameLabel.text = entity.country
        } else if selectAdress == SelectField.state {
            
            guard let entity = model as? StateEntity else { return }
            self.entity = entity
            
            flagImageView.isHidden = true
            nameLabel.text = entity.nameState
        }
    }
}
