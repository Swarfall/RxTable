//
//  TermCell.swift
//  RxTable
//
//  Created by Вячеслав on 03.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import UIKit

class TermCell: UITableViewCell {
    
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var termLabel: UILabel!
    
    static let identifier = "TermCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
        setupLabel()
    }
    
    private func setupButton() {
        termsButton.layer.borderWidth = 4
        termsButton.layer.borderColor = UIColor.blue.cgColor
        
        termsButton.layer.cornerRadius = termsButton.frame.width / 2
        termsButton.clipsToBounds = true
    }
    
    func setupLabel() {
        termLabel.isUserInteractionEnabled = true
        termLabel.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(TermCell.tapLabel(gesture:))))
    }
    
    @IBAction private func didTapConfirmButton(_ sender: Any) {
        changeBackground()
    }
    
    private func changeBackground() {
        if termsButton.backgroundColor == .white {
            termsButton.backgroundColor = .blue
        } else {
            termsButton.backgroundColor = .white
        }
    }
    
    func update(model: TermModel) {
        termLabel.text = model.termText
        mutableText(model: model)
    }
    
    func mutableText(model: TermModel) {
        if model.url != nil {
            let attributedString = NSMutableAttributedString(string: model.termText)
            attributedString.addAttribute(.link, value: model.url?.first ?? "", range: NSRange(location: 19, length: 18))
            attributedString.addAttribute(.link, value: model.url?[1] ?? "", range: NSRange(location: 49, length: 26))
            termLabel.attributedText = attributedString
        }
    }
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        //        if gesture.didTapAttributedTextInLabel(label: termLabel, inRange: NSRange(location: 19, length: 18)) {
        //            guard let model = model else { return }
        //            UIApplication.shared.canOpenURL(URL(string: (model.url?.first!)!)!)
        //        }
        print("tap")
    }
}
