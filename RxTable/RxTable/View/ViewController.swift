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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        bind()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: TermCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TermCell.identifier)
    }
    
    private func bind() {
        viewModel.terms
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: TermCell.identifier, cellType: TermCell.self)) { row, term, cell in
                cell.update(model: term)
        }.disposed(by: disposeBag)
        
        viewModel.showLoading.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: activiteIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
    }
}

