//
//  SecondViewController.swift
//  NBAStatsClient
//
//  Created by Jad  on 09/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import RxSwift

class SecondViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var loadingView: UIActivityIndicatorView! {
		didSet {
			loadingView.hidesWhenStopped = true
		}
	}

	private let disposeBag = DisposeBag()
	private let viewModel = CategoriesViewModel()


	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .clouds
		collectionView.backgroundColor = .clear
		title = "Categories"

		viewModel.categories.asDriver()
			.drive(onNext: { [unowned self] _ in
				self.collectionView.reloadData()
			}).disposed(by: disposeBag)

		viewModel
			.isLoading
			.asObservable()
			.bind(to: loadingView.rx.isAnimating)
			.disposed(by: disposeBag)

		collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
	}
}

extension SecondViewController: UICollectionViewDelegateFlowLayout {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfCategories
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		let name = viewModel.category(at: indexPath.row).name
		let font = UIFont.systemFont(ofSize: 14)
		let rect = font.sizeOfString(string: name, constrainedToWidth: collectionView.bounds.width - 16.0)
		return CGSize(width: rect.width + 16, height: 44)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let category = viewModel.category(at: indexPath.row)

		let isAlreadySelected = UserSelection.categories.value.contains { category.idcategories == $0.idcategories }
		if isAlreadySelected {
			UserSelection.remove(category: category)
		}
		else {
			UserSelection.add(category: category)
		}
		collectionView.reloadData()
	}
}

extension SecondViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as! CategoryCell
		let category = viewModel.category(at: indexPath.row)

		let selected = UserSelection.categories.value.contains { category.idcategories == $0.idcategories }

		let vModel = CategoryCellViewModel(title: category.name, selected: Variable(selected))
		cell.configure(viewModel: vModel)
		return cell
	}
}

