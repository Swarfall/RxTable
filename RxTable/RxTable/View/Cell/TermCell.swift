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
        termTextView.delegate = self
        termTextView.translatesAutoresizingMaskIntoConstraints = true
        termTextView.sizeToFit()
        termTextView.isScrollEnabled = false
        termTextView.isEditable = false
    }
    
    @IBAction private func didTapConfirmButton(_ sender: Any) {
        changeBackground()
    }
    
    private func changeBackground() {
        if termButton.backgroundColor == .white {
            termButton.backgroundColor = .blue
        } else {
            termButton.backgroundColor = .white
        }
    }
    
    func update(model: TermModel) {
        termTextView.attributedText = model.agreementText.htmlToAttributedString
        setupTextView()
    }
}

extension TermCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
