//
//  TermCell.swift
//  RxTable
//
//  Created by Вячеслав on 03.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TermCell: UITableViewCell {
    
    @IBOutlet private weak var termButton: UIButton!
    @IBOutlet private weak var termTextView: UITextView!
    
    static let identifier = "TermCell"
    
    private var isValid = false
    
    var muttableArray = ["Customer Information on Data Processing", "Depositor Information Sheet", "tax information", "Terms & Conditions", "General Terms & Conditions", "all other conditions"]
    
    var subscribeButtonAction: ((Bool) -> Void)?
    var linkTapped: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    private func setupButton() {
        termButton.layer.borderWidth = 2
        termButton.layer.borderColor = UIColor.link.cgColor
        
        termButton.layer.cornerRadius = termButton.frame.width / 2
        termButton.clipsToBounds = true
    }
    
    private func setupTextView() {
        termTextView.delegate = self
        termTextView.translatesAutoresizingMaskIntoConstraints = false
        termTextView.isScrollEnabled = false
        termTextView.isEditable = false
        termTextView.isSelectable = true
        termTextView.font = UIFont.systemFont(ofSize: 15)
        termTextView.selectedTextRange = termTextView.textRange(from: termTextView.beginningOfDocument,
                                                                to: termTextView.beginningOfDocument)
        termTextView.sizeToFit()
    }
    
    
    private func changeBackground() {
        isValid = !isValid
        
        if isValid == true {
            termButton.backgroundColor = .link
        } else {
            termButton.backgroundColor = .white
        }
    }
    
    @IBAction private func didTapConfirmButton(_ sender: Any) {
        changeBackground()
        subscribeButtonAction?(isValid)
    }
    
    func update(model: TermModel) {
        termTextView.attributedText = model.agreementText.htmlToAttributedString
        setupTextView()
    }
}

extension TermCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        linkTapped?("\(URL)")
        return false
    }
}
