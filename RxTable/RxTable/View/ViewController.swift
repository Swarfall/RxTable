//
//  ViewController.swift
//  RxTable
//
//  Created by Вячеслав on 03.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var activiteIndicator: UIActivityIndicatorView!
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    private var valid = [0: false, 1: false, 2: false, 3: false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        viewModel.getData()
        bind()
    }
    
    // MARK: - Private methods
    private func registerCell() {
        let nib = UINib(nibName: TermCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TermCell.identifier)
    }
    
    private func bind() {
        viewModel.terms
            .bind(to: tableView.rx.items(cellIdentifier: TermCell.identifier, cellType: TermCell.self)) { [weak self] row, terms, cell in
                cell.update(model: terms)
                cell.termButton.rx.tap
                    .asObservable()
                    .subscribe(onNext: { [weak self] _ in
                        cell.isValid == true ? self?.valid.updateValue(true, forKey: row) : self?.valid.updateValue(false, forKey: row)
                    }).disposed(by: self!.disposeBag)
        }.disposed(by: disposeBag)
        
        viewModel.showLoading.bind(to: activiteIndicator.rx.isAnimating).disposed(by: disposeBag)
    }
    
    private func presentAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Action method
    @IBAction func didTapContinueButton(_ sender: Any) {
        valid.values.allSatisfy({ $0 == true }) ? presentAlert(title: "SUCCESS") : presentAlert(title: "FAIL")
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
