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
        termTextView.delegate = self
        termTextView.translatesAutoresizingMaskIntoConstraints = true
        termTextView.isScrollEnabled = false
        termTextView.isEditable = false
        termTextView.font = .systemFont(ofSize: 17)
        termTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        termTextView.linkTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.blue]
        termTextView.sizeToFit()
        
    }
    
    @IBAction private func didTapConfirmButton(_ sender: Any) {
        isValid = !isValid
        changeBackground()
    }
    
    private func changeBackground() {
        if isValid == true {
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
