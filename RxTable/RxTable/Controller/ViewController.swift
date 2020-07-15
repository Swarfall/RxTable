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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkValid()
        setupBinds()
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
    
    private func checkValid() {
        viewModel = ViewModel(continueButton: continueButton.rx.tap.asObservable())
        viewModel.output.isValid.asObservable()
            .map( { [weak self] isValid in
                self?.presentAlert(title: isValid ? "SUCCESS" : "FAIL")
            })
        .subscribe(onNext: { print("") })
        .disposed(by: disposeBag)
    }
    
    private func presentAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

