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

final class MenuViewController: UIViewController {
    
    enum Layout {
        
        enum SuperviewLayout {
            static let corner: CGFloat = 24
        }
        
        enum SwipeViewLayout {
            static let frameX: CGFloat = -16
            static let frameY: CGFloat = 11
            static let frameWidth: CGFloat = 32
            static let frameHeight: CGFloat = 6
        }
        
        enum TableViewLayout {
            static let topConstant: CGFloat = 28
        }
    }
    
    // MARK: - Private properties
    private let tableView = UITableView()
    private lazy var swipeView = UIView()
    
    var selectField: SelectField!
    let disposeBag = DisposeBag()
    
    var menuViewModel: MenuViewModelType!
    
    // MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupCell()
        setupBind()
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = Layout.SuperviewLayout.corner
        
        view.addSubview(swipeView)
        swipeView.frame = CGRect(x: (view.frame.width / 2) + Layout.SwipeViewLayout.frameX,
                                 y: Layout.SwipeViewLayout.frameY,
                                 width: Layout.SwipeViewLayout.frameWidth,
                                 height: Layout.SwipeViewLayout.frameHeight)
        swipeView.backgroundColor = .lightGray
    }
    
    private func setupCell() {
        let nib = UINib(nibName: MenuCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MenuCell.identifier)
    }
    
    private func setupBind() {
        
        if selectField == SelectField.country {
            
            menuViewModel.input.fetchCountries()
            
            menuViewModel.output.countries
                .bind(to: tableView.rx.items(cellIdentifier: MenuCell.identifier, cellType: MenuCell.self)) { row, countries, cell in
                    cell.selectAdress = SelectField.country
                    cell.update(model: countries)
            }.disposed(by: disposeBag)
            
            tableView.rx.itemSelected
                .map { [weak self] indexPath -> MenuCell? in
                    self?.tableView.cellForRow(at: indexPath) as? MenuCell
            }
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] cell in
                guard let self = self else { return}
                self.menuViewModel.input.entityProperty.accept(cell.entity)
                self.dismiss(animated: true)
                }).disposed(by: disposeBag)
            
        } else if selectField == SelectField.state {
            // TODO: -  tableView.rx.itemSelected for germanyStates
        }
    }
}

extension MenuViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Layout.TableViewLayout.topConstant).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.separatorStyle = .none
    }
}
