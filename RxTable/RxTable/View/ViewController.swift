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
    
    @IBOutlet private weak var cityTextField: UITextField!
    @IBOutlet private weak var countryTextField: UITextField!
    @IBOutlet private weak var stateTextField: UITextField!
    @IBOutlet private weak var continueButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private var viewModel: ViewModelType!
    private let transition = PanelTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        checkValid()
        setupBinds()
        setupTaps()
    }
    
    private func setupBinds() {
        cityTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.city)
            .disposed(by: disposeBag)
        
        countryTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.country)
            .disposed(by: disposeBag)
        
        stateTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.state)
            .disposed(by: disposeBag)
    }
    
    private func setupTaps() {
        let countryTap = UITapGestureRecognizer(target: self, action: #selector(countryTapped(_:)))
        countryTextField.addGestureRecognizer(countryTap)
        countryTap.numberOfTouchesRequired = 1
        countryTap.numberOfTapsRequired = 1
    }
    
    @objc private func countryTapped(_ sender: UITapGestureRecognizer) {
        let child = MenuViewController()
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        child.selectField = SelectField.country
        present(child, animated: true)
    }
    
    private func checkValid() {
        continueButton.rx.tap
            .bind { [weak self] in
                self?.presentAlert(title: self?.viewModel.output.checkFieldsFilling() ?? "zzz")
        }.disposed(by: disposeBag)
    }
    
    private func presentAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
