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

class TermCell: UITableViewCell {
    
    @IBOutlet private weak var termButton: UIButton!
    @IBOutlet weak var termTextView: UITextView!
    
    static let identifier = "TermCell"
    
    var isValid = false
    var disposeBag = DisposeBag()
    var subscribeButtonAction: ((TermCell) -> (Void))?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    private func setupButton() {
        termButton.layer.borderWidth = 2
        termButton.layer.borderColor = UIColor.link.cgColor
        
        termButton.layer.cornerRadius = termButton.frame.width / 2
        termButton.clipsToBounds = true
    }
    
    private func setupTextView() {
        termTextView.translatesAutoresizingMaskIntoConstraints = false
        termTextView.isScrollEnabled = false
        termTextView.isEditable = false
        termTextView.isSelectable = true
        termTextView.font = UIFont.systemFont(ofSize: 15)
        termTextView.selectedTextRange = termTextView.textRange(from: termTextView.beginningOfDocument,
                                                                to: termTextView.beginningOfDocument)
        termTextView.sizeToFit()
    }
    
    func changeBackground() {
        isValid = !isValid
        
        if isValid == true {
            termButton.backgroundColor = .link
        } else {
            termButton.backgroundColor = .white
        }
    }
    
    @IBAction private func didTapConfirmButton(_ sender: Any) {
        subscribeButtonAction?(self)
    }
    
    func update(model: TermModel) {
        termTextView.attributedText = model.agreementText.htmlToAttributedString
        setupTextView()
    }
}
