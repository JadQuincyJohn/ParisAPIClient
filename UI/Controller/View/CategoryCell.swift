//
//  CategoryCell.swift
//  NBAStatsClient
//
//  Created by Jad  on 16/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import UIKit
import RxSwift


struct CategoryCellViewModel {
	let title: String
	let selected: Variable<Bool>
}

final class CategoryCell: UICollectionViewCell, Reusable {

	@IBOutlet weak var titleLabel: UILabel!

	var viewModel: CategoryCellViewModel!
	private let disposeBag = DisposeBag()


	override func awakeFromNib() {
		super.awakeFromNib()
		titleLabel.font = UIFont.systemFont(ofSize: 14)
	}

	func configure(viewModel: CategoryCellViewModel) {
		self.viewModel = viewModel
		titleLabel.text = viewModel.title

		viewModel.selected
			.asDriver()
			.drive(onNext: { [unowned self] _ in
				self.toggleSelection()

			}).disposed(by: disposeBag)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = bounds.size.height / 2
		layer.masksToBounds = true
	}

	func toggleSelection() {

		if viewModel.selected.value {
			backgroundColor = .emerald
			titleLabel.textColor = .white
			layer.borderColor = UIColor.emerald?.cgColor
		} else {
			backgroundColor = .clouds
			titleLabel.textColor = .emerald
			layer.borderColor = UIColor.emerald?.cgColor
			layer.borderWidth = 1
		}
	}
}
