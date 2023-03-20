//
//  MainPageViewController.swift
//  cocktailsApp
//
//  Created by Eldar on 19/2/23.
//

import UIKit
import SnapKit

protocol CocktailsMenuViewModelFactory {
    func createCocktailsMenuViewModel() -> CocktailsMenuViewModel
}

class DefaultCocktailsMenuViewModelFactory: CocktailsMenuViewModelFactory {
    func createCocktailsMenuViewModel() -> CocktailsMenuViewModel {
        return CocktailsMenuViewModel()
    }
}

class CocktailsMenuViewController: UIViewController {
    
    private let viewModelFactory: CocktailsMenuViewModelFactory
    
    init(viewModelFactory: CocktailsMenuViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var viewModel: CocktailsMenuViewModel = {
        viewModelFactory.createCocktailsMenuViewModel()
    }()
    
    private var favouriteDrinksArray: [Drinks] = []
    
    private func initViewModel() {
        isLoading = true
        viewModel.getDrinksWithLetter()
        viewModel.reloadDrinksCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.drinksCollectionView.reloadData()
                
            }
        }
        viewModel.showErrorAlert = { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlert(error: error)
            }
        }
        viewModel.dataFoundWithName = { [weak self] result in
            DispatchQueue.main.async {
                self?.noCocktailsFoundLabel.isHidden = result
                self?.isLoading = false
            }
        }
    }
    
    private func showErrorAlert(error: String) {
        let errorAlert = UIAlertController(
            title: "Error",
            message: error,
            preferredStyle: .alert)
        errorAlert.addAction(
            .init(title: "OK", style: .default)
        )
        present(errorAlert, animated: true)
    }
    
    private lazy var allDrinksTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tastiest Cocktails"
        label.font = UIFont(name: "Avenir Next Bold", size: 26)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pageInfoSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Find the best selling cocktails.\n All drinks are freshly prepared."
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Roman", size: 18)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // UISearchBar for searching drink by name.
    private lazy var searchDrinkSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search nice drink"
        searchBar.searchTextField.font = UIFont(name: "Avenir-Roman", size: 17)
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = ColorConstants.background
        searchBar.searchTextField.backgroundColor = .white
        searchBar.enablesReturnKeyAutomatically = false
        
        // Shadow configuration
        searchBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        searchBar.layer.shadowOpacity = 1
        searchBar.layer.shadowRadius = 4
        searchBar.layer.masksToBounds = false
        return searchBar
    }()
    
    // Background view for UICollectionView creating
    private lazy var backgroundViewForCollection: UIView = {
        let view = UIView()
        view.backgroundColor = ColorConstants.cellBack
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    // UICollectionView creating
    private lazy var drinksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // No Cocktails found Label creating.
    private lazy var noCocktailsFoundLabel: UILabel = {
        let label =  UILabel(
            frame: CGRect(
                x: 0,
                y: 0,
                width: drinksCollectionView.bounds.size.width,
                height: 50
            )
        )
        label.text = "Oops, there is No cocktail with this name😊\nPlease, try another drink,\n or text to support and we will add it"
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.startAnimating()
        return view
    }()
    
    private lazy var isLoading: Bool = false {
        didSet {
            _ = isLoading ? activityIndicator.startAnimating() :activityIndicator.stopAnimating()
        }
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = ColorConstants.background
        setupSubViews()
        setUPConstraints()
        configureDrinksCollectionView()
        configureSearchDrinkSearchBar()
        initViewModel()
    }
    
    private func setupSubViews() {
        view.addSubview(allDrinksTitleLabel)
        view.addSubview(pageInfoSubtitleLabel)
        view.addSubview(searchDrinkSearchBar)
        view.addSubview(backgroundViewForCollection)
        view.addSubview(drinksCollectionView)
        view.addSubview(noCocktailsFoundLabel)
        view.addSubview(activityIndicator)
    }
    
    private func configureSearchDrinkSearchBar() {
        searchDrinkSearchBar.delegate = self
    }
    
    private func configureDrinksCollectionView() {
        drinksCollectionView.register(
            MenuCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuCollectionViewCell.identifier
        )
        drinksCollectionView.delegate = self
        drinksCollectionView.dataSource = self
    }
    
    private func setUPConstraints() {
        allDrinksTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.centerX.equalToSuperview()
        }
        
        pageInfoSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(allDrinksTitleLabel.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.height.equalTo(77)
        }
        
        searchDrinkSearchBar.snp.makeConstraints { make in
            make.top.equalTo(pageInfoSubtitleLabel.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
        backgroundViewForCollection.snp.makeConstraints { make in
            make.top.equalTo(searchDrinkSearchBar.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(35)
            make.left.right.bottom.equalToSuperview()
        }
        
        drinksCollectionView.snp.makeConstraints { make in
            make.top.equalTo(backgroundViewForCollection.snp.top)
            make.left.equalTo(backgroundViewForCollection.snp.left).offset(20)
            make.right.equalTo(backgroundViewForCollection.snp.right).offset(-20)
            make.bottom.equalTo(backgroundViewForCollection.snp.bottom)
        }
        
        noCocktailsFoundLabel.snp.makeConstraints { make in
            make.centerX.equalTo(drinksCollectionView.snp.centerX)
            make.centerY.equalTo(drinksCollectionView.snp.centerY)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(24)
        }
    }
}


extension CocktailsMenuViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int { viewModel.filteredDrinks.count }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = drinksCollectionView.dequeueReusableCell(
            withReuseIdentifier: MenuCollectionViewCell.identifier,
            for: indexPath
        ) as? MenuCollectionViewCell else { fatalError("cell does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}

extension CocktailsMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellCustomWidth = (collectionView.bounds.width - 30) / 2
        return CGSize(width: cellCustomWidth, height: cellCustomWidth + 7)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let viewModelProvider = DefaultChoosedCocktailViewModelProvider()
        let vc = ChoosedCocktailViewController(viewModelProvider: viewModelProvider)
        vc.viewModel.drink = viewModel.filteredDrinks[indexPath.row]
//        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func moveToNextLetter(
        letter: inout String,
        value: inout UInt32
    ) {
        value += 1
        let scalar = UnicodeScalar(value)!
        letter = String(scalar)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Check if the user has scrolled to the bottom of the view and it is not
        // searching cocktail process
        let scrollViewContentHeight = drinksCollectionView.contentSize.height
        let scrollOffsetThreshold = scrollViewContentHeight - drinksCollectionView.bounds.size.height
        
        if scrollView.contentOffset.y > scrollOffsetThreshold,
           searchDrinkSearchBar.text!.isEmpty {
            viewModel.getDrinksWithNextLetter()
        }
    }
}

extension CocktailsMenuViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) { viewModel.getDrinksWithName(searchText) }
}

//extension CocktailsMenuViewController: SelecetProductDelegate {
//    func addNewDrink(_ drink: Drinks) {
//        
//        viewModel.favouriteDrinksArray.append(drink)
//        func updateFavouriteDrinks() {
//
//            // notification with the updated array
//            NotificationCenter.default.post(name: Notification.Name("FavouriteDrinksUpdated"), object: nil, userInfo: ["favouriteDrinksArray": favouriteDrinksArray])
//        }
//        print("❤️delegate added in CocktailsMenuViewModel, there are 👉  \(viewModel.favouriteDrinksArray.count) elements in array: \(viewModel.favouriteDrinksArray)❤️")
//    }
//
//    func removeLastDrink(_ drink: Drinks) {
//        viewModel.favouriteDrinksArray.removeLast()
//        print("❤️delegate removed, there are 👉 \(viewModel.favouriteDrinksArray.count) elements in array: \(viewModel.favouriteDrinksArray)❤️")
//    }
//}
