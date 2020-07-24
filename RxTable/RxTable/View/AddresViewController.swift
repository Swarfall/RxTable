//
//  AddresViewController.swift
//  RxTable
//
//  Created by Вячеслав on 03.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class AddresViewController: UIViewController {
    
    @IBOutlet private weak var cityTextField: UITextField!
    @IBOutlet private weak var countryTextField: UITextField!
    @IBOutlet private weak var stateTextField: UITextField!
    @IBOutlet private weak var continueButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private var addressViewModel: AddressViewModelType!
    private let transition = PanelTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressViewModel = AddressViewModel()
        checkValid()
        setupBinds()
        setupTaps()
    }
    
    private func setupBinds() {
        
        cityTextField.rx.text
            .orEmpty
            .bind(to: addressViewModel.input.city)
            .disposed(by: disposeBag)
        
        addressViewModel.output.cityString
            .bind(to: cityTextField.rx.text)
            .disposed(by: disposeBag)
        
        stateTextField.rx.text
            .orEmpty
            .bind(to: addressViewModel.input.state)
            .disposed(by: disposeBag)
        
        addressViewModel.output.stateString
            .bind(to: stateTextField.rx.text)
            .disposed(by: disposeBag)
        
        addressViewModel.output.menuViewModel.state
            .subscribe(onNext: { [weak self] state in
                guard let self = self, let state = state?.nameState else { return }
                self.addressViewModel.input.state.accept(state)
            }).disposed(by: disposeBag)
        
        addressViewModel.output.menuViewModel.country
            .subscribe(onNext: { [weak self] entity in
                guard let self = self else { return }
                self.addressViewModel.input.entity.accept(entity)
            }).disposed(by: disposeBag)
        
        addressViewModel.output.countryString
            .bind(to: countryTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupTaps() {
        let countryTap = UITapGestureRecognizer(target: self, action: #selector(countryTapped(_:)))
        countryTextField.addGestureRecognizer(countryTap)
        countryTap.numberOfTouchesRequired = 1
        countryTap.numberOfTapsRequired = 1
        
        let gerStateTap = UITapGestureRecognizer(target: self, action: #selector(stateTapped(_:)))
        stateTextField.addGestureRecognizer(gerStateTap)
        gerStateTap.numberOfTouchesRequired = 1
        gerStateTap.numberOfTapsRequired = 1
    }
    
    @objc private func countryTapped(_ sender: UITapGestureRecognizer) {
        
        let child = MenuViewController()
        child.selectField = SelectField.country
        child.menuViewModel = addressViewModel.output.menuViewModel
        
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        present(child, animated: true)
    }
    
    @objc private func stateTapped(_ sender: UITapGestureRecognizer) {
        if addressViewModel.input.entity.value?.code == State.ger.rawValue {
            
            let child = MenuViewController()
            child.modalPresentationStyle = .custom
            child.selectField = SelectField.state
            child.menuViewModel = addressViewModel.output.menuViewModel
            child.transitioningDelegate = transition
            child.modalPresentationStyle = .custom
            present(child, animated: true)
        } else {
            stateTextField.becomeFirstResponder()
        }
    }
    
    private func checkValid() {
        continueButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.presentAlert(title: self.addressViewModel.output.checkFieldsFilling())
        }.disposed(by: disposeBag)
    }
    
    private func presentAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
