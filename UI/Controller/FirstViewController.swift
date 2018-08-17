//
//  FirstViewController.swift
//  NBAStatsClient
//
//  Created by Jad  on 09/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FirstViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var loadingView: UIActivityIndicatorView! {
		didSet {
			loadingView.hidesWhenStopped = true
		}
	}

	private let disposeBag = DisposeBag()
	private let viewModel = EventsViewModel(categories: UserSelection.categories)

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .clouds
		tableView.backgroundColor = .clear
		title = "Events"

		tableView.estimatedRowHeight = 100

		viewModel.events.asDriver()
			.drive(onNext: { [unowned self] _ in
				self.tableView.reloadData()
			}).disposed(by: disposeBag)

		viewModel
			.isLoading
			.asObservable()
			.bind(to: loadingView.rx.isAnimating)
			.disposed(by: disposeBag)

		viewModel.filters
			.asDriver()
			.drive(onNext: { [unowned self] _ in
				self.tableView.reloadData()
			}).disposed(by: disposeBag)
	}
}

extension FirstViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let event = viewModel.event(at: indexPath.row)

		let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "Cell")

		cell.textLabel?.text = event.title
		cell.textLabel?.numberOfLines = 2
		cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		cell.textLabel?.textColor = .alizarin
		cell.detailTextLabel?.text = event.leadText
		cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
		cell.detailTextLabel?.numberOfLines = 0
		cell.detailTextLabel?.textColor = .midnight_blue
		cell.accessoryType = .disclosureIndicator
		cell.selectionStyle = .none
		cell.backgroundColor = .clear

		return cell
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfEvents
	}
}

