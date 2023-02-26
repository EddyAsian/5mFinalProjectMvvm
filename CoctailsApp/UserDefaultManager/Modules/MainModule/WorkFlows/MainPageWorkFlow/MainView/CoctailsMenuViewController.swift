//
//  MainPageViewController.swift
//  cocktailsApp
//
//  Created by Eldar on 19/2/23.
//

import UIKit
import SnapKit
import RxRelay

class CocktailsMenuViewController: UIViewController {
    
    private var viewModel: MainViewModelType = MainViewModel()
    
    private var basketArray: [Drinks] = []
    
    // For requesting to API to get next letter's drinks
    private var currentLetterUnicodeVoralue: UInt32 = 97
    private var currentLetter = "a"
    
    
    
    private var drinks: [Drinks] = [] {
        didSet {
            filteredDrinks = drinks
        }
    }
    
    private var filteredDrinks = [Drinks]() {
        didSet {
            updateUIwithSearchResultsState(resultIsEmpty: filteredDrinks.isEmpty)
            drinksCollectionView.reloadData()
        }
    }
    
    // MARK: Subviews creating
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
        getDrinksForLetter(currentLetter)
        
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
    
    // MARK: Call API methods ()
    private func getDrinksForLetter(_ letter: String) {
        Task {
            isLoading = true
            let drinksFromAPI = try await viewModel.getDrinksForLetter(letter).drinks ?? []
            drinks.append(contentsOf: drinksFromAPI)
            isLoading = false
        }
    }
    
    private func getDrinksForName(_ name: String) {
        Task {
            filteredDrinks = try await viewModel.getDrinksByName(name).drinks ?? []
        }
    }
    
    private func updateUIwithSearchResultsState(resultIsEmpty: Bool) {
        if filteredDrinks.isEmpty && !drinks.isEmpty {
            drinksCollectionView.isHidden = true
            noCocktailsFoundLabel.isHidden = false
        } else {
            drinksCollectionView.isHidden = false
            noCocktailsFoundLabel.isHidden = true
        }
    }
    
    // MARK: Configuring methods ()
    private func configureSearchDrinkSearchBar() {
        searchDrinkSearchBar.delegate = self
    }
    
    private func configureDrinksCollectionView() {
        drinksCollectionView.register(
            MenuCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuCollectionViewCell.reuseID
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
    ) -> Int { filteredDrinks.count }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = drinksCollectionView.dequeueReusableCell(
            withReuseIdentifier: MenuCollectionViewCell.reuseID,
            for: indexPath
        ) as? MenuCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: filteredDrinks[indexPath.row])
        return cell
    }
}

extension CocktailsMenuViewController: UICollectionViewDelegateFlowLayout {
    private func moveToNextLetter(
        letter: inout String,
        value: inout UInt32
    ) {
        value += 1
        let scalar = UnicodeScalar(value)!
        letter = String(scalar)
    }
    
    private func fetchNextData () {
        moveToNextLetter(
            letter: &currentLetter,
            value: &currentLetterUnicodeVoralue
        )
        getDrinksForLetter(currentLetter)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Check if the user has scrolled to the bottom of the view and it is not
        // searching cocktail process
        let scrollViewContentHeight = drinksCollectionView.contentSize.height
        let scrollOffsetThreshold = scrollViewContentHeight - drinksCollectionView.bounds.size.height
        
        if scrollView.contentOffset.y > scrollOffsetThreshold,
            searchDrinkSearchBar.text!.isEmpty {
            fetchNextData()
        }
    }
}

extension CocktailsMenuViewController {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellCustomWidth = (collectionView.bounds.width - 50) / 2
        return CGSize(width: cellCustomWidth, height: cellCustomWidth + 11)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let coctailVC = ChoosedCocktailViewController()
        let model = filteredDrinks[indexPath.row]
        coctailVC.delegate = self
        
        let observe = BehaviorRelay<Drinks>(value: model)
        observe.subscribe(onNext: { drinks in
            coctailVC.cocktail = drinks
            print("I do like RX: \(coctailVC.cocktail as Any)")
        })
//        coctailVC.delegate = self
        navigationController?.pushViewController(coctailVC, animated: true)
    }
}

extension CocktailsMenuViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        guard !searchText.isEmpty else { filteredDrinks = drinks; return }
        getDrinksForName(searchText)
    }
}

extension CocktailsMenuViewController: SelecetProductDelegate {
    func addNewDrink(_ drink: Drinks) {
        basketArray.append(drink)
        print("Added throw delegate and now there are elements in array: \(basketArray)")
    }
    
    func removeLastDrink(_ drink: Drinks) {
        basketArray.removeLast()
        print("Removed throw delegate and now there are elements in array: \(basketArray)")
    }
}
