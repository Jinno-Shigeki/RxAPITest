//
//  ViewController.swift
//  RxAPIList
//
//  Created by 神野成紀 on 2020/09/23.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textField: UITextField!
    private let viewModel = ViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.rx.text.orEmpty
            .filter {$0.count >= 1}
            .debounce(DispatchTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { (word) in
                self.viewModel.searchWordObserver.onNext(word)
            })
        .disposed(by: disposeBag)
        
        viewModel.userOvservable
            .drive(tableView.rx.items(cellIdentifier: "cell")) {row, element, cell in
            cell.textLabel?.text = element.login
        }.disposed(by: disposeBag)
    }
}
