//
//  MenuViewController.swift
//  RxTable
//
//  Created by Вячеслав on 17.07.2020.
//  Copyright © 2020 ViacheslavSavitsky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum SelectField {
    case country
    case state
}

enum State {
    case ger
    case another
}

class MenuViewController: UIViewController {
    
    // MARK: - Private properties
    private let tableView = UITableView()
    private lazy var swipeView = UIView()
    
    var selectField: SelectField!
    let disposeBag = DisposeBag()
    
    let menuViewModel = MenuViewModel()
    
    // MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupCell()
        menuViewModel.fetchCountries()
        setupBind()
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        
        view.addSubview(swipeView)
        swipeView.frame = CGRect(x: (view.frame.width / 2) - 16,
                                 y: 11,
                                 width: 32,
                                 height: 6)
        swipeView.backgroundColor = .lightGray
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 28).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.separatorStyle = .none
    }
    
    private func setupCell() {
        let nib = UINib(nibName: MenuCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MenuCell.identifier)
    }
    
    private func setupBind() {
        if selectField == SelectField.country {
            // TODO: - cellForRowAt IndexPath
            menuViewModel.countries
                .bind(to: tableView.rx.items(cellIdentifier: MenuCell.identifier, cellType: MenuCell.self)) { row, countries, cell in
                    cell.selectAdress = SelectField.country
                    cell.update(model: countries)
            }.disposed(by: disposeBag)
            
            // TODO: - didSelectRowAt IndexPath
            tableView.rx.itemSelected
                .subscribe(onNext: { [weak self] indexPath in
                    let cell = self?.tableView.cellForRow(at: indexPath) as? MenuCell
                    self?.menuViewModel.addressViewModel.input.country.accept(cell?.country ?? "dont success country") // TODO: - завтык с передачей стринги в текстФилду на главном контроллере
                    self?.menuViewModel.addressViewModel.input.code.accept(cell?.stateCode ?? "dont success code")
                    self?.dismiss(animated: true)
                }).disposed(by: disposeBag)
            
        } else if selectField == SelectField.state {
            menuViewModel.gerStates
                .bind(to: tableView.rx.items(cellIdentifier: MenuCell.identifier, cellType: MenuCell.self)) { row, countries, cell in
                    cell.selectAdress = SelectField.state
                    cell.update(model: countries)
            }.disposed(by: disposeBag)
        }
    }
    
}
