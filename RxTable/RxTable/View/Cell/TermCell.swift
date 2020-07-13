//
//  TermCell.swift
//  RxTable
//
//  Created by Вячеслав on 03.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import UIKit

class TermCell: UITableViewCell {
    
    @IBOutlet weak var termButton: UIButton!
    @IBOutlet weak var termTextView: UITextView!
    
    static let identifier = "TermCell"
    
    var isValid = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    private func setupButton() {
        termButton.layer.borderWidth = 4
        termButton.layer.borderColor = UIColor.blue.cgColor
        
        termButton.layer.cornerRadius = termButton.frame.width / 2
        termButton.clipsToBounds = true
    }
    
    private func setupTextView() {
        termTextView.translatesAutoresizingMaskIntoConstraints = false
        termTextView.isScrollEnabled = false
        termTextView.isEditable = false
        termTextView.selectedTextRange = termTextView.textRange(from: termTextView.beginningOfDocument, to: termTextView.beginningOfDocument)
        termTextView.sizeToFit()
    }
    
    private func changeBackground() {
        if isValid == true {
            termButton.backgroundColor = .blue
        } else {
            termButton.backgroundColor = .white
        }
    }
    
    @IBAction private func didTapConfirmButton(_ sender: Any) {
        isValid = !isValid
        changeBackground()
    }
    
    func update(model: TermModel) {
        termTextView.attributedText = model.agreementText.htmlToAttributedString
        setupTextView()
    }
}
