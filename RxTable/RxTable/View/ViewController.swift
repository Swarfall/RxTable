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
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var continueButton: UIButton!
    @IBOutlet weak private var activiteIndicator: UIActivityIndicatorView!
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    private var valid = [Int: Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        viewModel.fetchTerms()
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
                self?.valid[row] = false
                cell.subscribeButtonAction = { [weak self] isValid in
                    self?.valid.updateValue(isValid, forKey: row)
                }
                cell.linkTapped = { [weak self] link in
                    self?.presentAlert(title: link)
                }
        }.disposed(by: disposeBag)
        
        viewModel.loadProgress.bind(to: self.activiteIndicator.rx.isAnimating).disposed(by: disposeBag)
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
