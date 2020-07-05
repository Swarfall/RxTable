//
//  TermCell.swift
//  RxTable
//
//  Created by Вячеслав on 03.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import UIKit

class TermCell: UITableViewCell {

    @IBOutlet private weak var termsLabel: UILabel!
    @IBOutlet private weak var termsButton: UIButton!
    
    var isSelect: Bool = false
    
    static let identifier = "TermCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }

    private func setupButton() {
        termsButton.layer.borderWidth = 4
        termsButton.layer.borderColor = UIColor.blue.cgColor
        
        termsButton.layer.cornerRadius = termsButton.frame.width / 2
        termsButton.clipsToBounds = true
    }
    
    @IBAction private func didTapConfirmButton(_ sender: Any) {
        isSelect = !isSelect
        changeBackground()
    }
    
    private func changeBackground() {
        if isSelect == true {
            termsButton.backgroundColor = .blue
        } else {
            termsButton.backgroundColor = .white
        }
    }
    
    func update(model: TermModel) {
        termsLabel.text = model.termText
        isSelect = model.isSelect
    }
}
