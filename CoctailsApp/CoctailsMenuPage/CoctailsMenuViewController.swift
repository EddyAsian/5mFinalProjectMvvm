//
//  ViewController.swift
//  CoctailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

class CoctailsMenuViewController: UIViewController {
    
    let coctailsMenuViewModel = CoctailsMenuViewModel()
    
    lazy var menuPagesHeader: UILabel = {
        var menuPagesHeader = UILabel()
        menuPagesHeader.text = "Tastiest Cocktails"
        menuPagesHeader.textAlignment = .center
        menuPagesHeader.font = .systemFont(ofSize: 26, weight: .semibold)
        menuPagesHeader.textColor = .white
        return menuPagesHeader
    }()
    
    lazy var menuPagesDescription: UILabel = {
        var menuPagesDescription = UILabel()
        menuPagesDescription.text =
        "Find the best selling cocktails. All drinks are freshly prepared."
        menuPagesDescription.textAlignment = .center
        menuPagesDescription.font = UIFont(name: "Avenir Next", size: 19)
        menuPagesDescription.textColor = .white
        menuPagesDescription.numberOfLines = 0
        return menuPagesDescription
    }()
    
    lazy var menuPagesSearchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.searchTextField.placeholder = "Search Menu"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .white
        searchBar.searchTextField.font = .systemFont(ofSize: 17, weight: .thin)
        return searchBar
    }()
    
    
    lazy var menuCollectionView: UICollectionView = {
        var viewLayout = UICollectionViewFlowLayout()
        viewLayout.itemSize = CGSize(width: 191, height: 170)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = UIColor.cellBack
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        setUpCollectionView()
        setUpUI()
        fetchData()
    }
    
    private func fetchData() {
        Task {
            do {
                try await coctailsMenuViewModel.fetchCoctailsData()
                menuCollectionView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func setUpCollectionView() {
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.register(
            MenuCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuCollectionViewCell.reuseIdentifier
        )
    }
    
    private func setUpSubviews() {
        view.addSubview(menuPagesHeader)
        view.addSubview(menuPagesDescription)
        view.addSubview(menuPagesSearchBar)
        view.addSubview(menuCollectionView)
    }
    
    private func setUpConstraints() {
        menuPagesHeader.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().offset(60)
            maker.centerX.equalToSuperview()
        }
        
        menuPagesDescription.snp.makeConstraints{ maker in
            maker.top.equalTo(menuPagesHeader.snp.bottom)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(284)
            maker.height.equalTo(77)
        }
        
        menuPagesSearchBar.snp.makeConstraints{ maker in
            maker.top.equalTo(menuPagesDescription.snp.bottom)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(232)
            maker.height.equalTo(37)
        }
        
        menuCollectionView.snp.makeConstraints{ maker in
            maker.top.equalTo(menuPagesSearchBar.snp.bottom).offset(10)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview().inset(50)
        }
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
}

extension CoctailsMenuViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        coctailsMenuViewModel.returnCoctailsCount()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? MenuCollectionViewCell else { fatalError() }
        let product = coctailsMenuViewModel.returnCoctail(at: indexPath.row)
        cell.displayInfo(product: product)
        return cell
    }
}

extension CoctailsMenuViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let coctailVC = CoctailViewController()
        let model = coctailsMenuViewModel.returnCoctail(at: indexPath.row)
        var observe = BehaviorRelay<Drinks>(value: model)
        observe.subscribe(onNext: { drinks in
            coctailVC.coctail = drinks
            print(coctailVC.coctail)
        })
        navigationController?.pushViewController(coctailVC, animated: true)
    }
}




