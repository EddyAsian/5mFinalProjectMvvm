
//
//  MainPageViewController.swift
//  cocktailsApp
//
//  Created by Eldar on 19/2/23.
//

import UIKit
import SnapKit
import RxRelay


extension UIView {
    static func identifier() -> String {
        String(describing: self)
    }
}

extension UICollectionView {
    enum ReusableViewType: String {
        case UICollectionElementKindSectionHeader
        case UICollectionElementKindSectionFooter
    }
    
    func registerReusable<Cell: UICollectionViewCell>(CellType: Cell.Type) {
        register(CellType, forCellWithReuseIdentifier: CellType.identifier())
    }
    
    func dequeueIdentifiableCell<Cell: UICollectionViewCell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell {
        let reuseId = Cell.identifier()
        guard let cell = dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? Cell else { fatalError() }
        return cell
    }
    
    func registerReusableView<View: UICollectionReusableView>(ViewType: View.Type, type: ReusableViewType) {
        register(ViewType, forSupplementaryViewOfKind: type.rawValue, withReuseIdentifier: View.identifier())
    }
    
    func dequeuReusableView<View: UICollectionReusableView>(ViewType: View.Type, type: ReusableViewType, for indexPath: IndexPath) -> View {
        let reuseId = View.identifier()
        guard let view = dequeueReusableSupplementaryView(ofKind: type.rawValue,
                                                          withReuseIdentifier: reuseId,
                                                          for: indexPath) as? View
        else { fatalError() }
        return view
    }
}



class BasketViewController: UIViewController {
    
    
    var cocktail: Drinks?
    
    private var viewModel: MainViewModelType = MainViewModel()
  
    // For requesting to API to get next letter's drinks
    private var currentLetterUnicodeVoralue: UInt32 = 97
    private var currentLetter = "a"
  
    private var drinks = [Drinks]() {
        didSet {
            filteredDrinks = drinks
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
    
    private var filteredDrinks = [Drinks]() {
        didSet {
            updateUIwithSearchResultsState(resultIsEmpty: filteredDrinks.isEmpty)
            drinksCollectionView.reloadData()
        }
    }
    
    // MARK: Call API methods ()
    private func getDrinksForLetter(_ letter: String) {
        Task {
            let drinksFromAPI = try await viewModel.getDrinksForLetter(letter).drinks ?? []
            drinks.append(contentsOf: drinksFromAPI)
        }
    }
    
    private func getDrinksForName(_ name: String) {
        Task {
            filteredDrinks = try await viewModel.getDrinksByName(name).drinks ?? []
        }
    }

    // MARK: Subviews creating
    private lazy var allDrinksTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your orders"
        label.font = UIFont(name: "Avenir Next Bold", size: 26)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pageInfoSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Check your choosed drinks\n and we will deliver them."
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Roman", size: 18)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // UISearchBar for searching drink by name.
    private lazy var searchDrinkSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search purchased cocktails"
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
    
    
    private lazy var drinksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth, height: 10)
                layout.minimumLineSpacing = 6
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        view.registerReusable(CellType: BasketCollectionViewCell.self)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
//    private lazy var drinksCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: screenWidth, height: 10)
//        layout.minimumLineSpacing = 2
////        layout.headerReferenceSize = CGSize(width: screenWidth, height: 40)
////        layout.footerReferenceSize = CGSize(width: screenWidth, height: 20)
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.delegate = self
//        view.dataSource = self
//        view.registerReusable(CellType: BasketCollectionViewCell.self)
////        view.registerReusableView(ViewType: BasketHeaderView.self, type: .UICollectionElementKindSectionHeader)
////        view.registerReusableView(ViewType: BasketFooterView.self, type: .UICollectionElementKindSectionFooter)
//        view.backgroundColor = ColorConstants.cellBack
//        return view
//    }()
    
    
    
    // No Cocktails found Label creating. Appears in case if
    // there is no cocktail found with name that was input.
    private lazy var noCocktailsFoundLabel: UILabel = {
        let label =  UILabel(
            frame: CGRect(
                x: 0,
                y: 0,
                width: drinksCollectionView.bounds.size.width,
                height: 50
            )
        )
        label.text = "Oops, there is No cocktail with this name😊\n Maybe you didn't buy it yet?"
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    override func loadView() {
        super.loadView()
        updateUI()
        configureDrinksCollectionView()
        configureSearchDrinkSearchBar()
        getDrinksForLetter(currentLetter)
    }
    
    // MARK: updateUI() method
    private func updateUI() {
        view.backgroundColor = ColorConstants.description
        
        view.addSubview(allDrinksTitleLabel)
        allDrinksTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(pageInfoSubtitleLabel)
        pageInfoSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(allDrinksTitleLabel.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
//            make.width.equalTo(232)
            make.height.equalTo(77)
        }
        
        view.addSubview(searchDrinkSearchBar)
        searchDrinkSearchBar.snp.makeConstraints { make in
            make.top.equalTo(pageInfoSubtitleLabel.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
        view.addSubview(backgroundViewForCollection)
        backgroundViewForCollection.snp.makeConstraints { make in
            make.top.equalTo(searchDrinkSearchBar.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(35)
            make.left.right.bottom.equalToSuperview()
        }

        view.addSubview(drinksCollectionView)
        drinksCollectionView.snp.makeConstraints { make in
            make.top.equalTo(backgroundViewForCollection.snp.top)
            make.left.equalTo(backgroundViewForCollection.snp.left).offset(20)
            make.right.equalTo(backgroundViewForCollection.snp.right).offset(-20)
            make.bottom.equalTo(backgroundViewForCollection.snp.bottom)
        }
        
        view.addSubview(noCocktailsFoundLabel)
        noCocktailsFoundLabel.snp.makeConstraints { make in
            make.centerX.equalTo(drinksCollectionView.snp.centerX)
            make.centerY.equalTo(drinksCollectionView.snp.centerY)
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
    
    
}

extension BasketViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int { filteredDrinks.count }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = drinksCollectionView.dequeueReusableCell(
            withReuseIdentifier: BasketCollectionViewCell.reuseID,
            for: indexPath
        ) as? BasketCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: filteredDrinks[indexPath.row])
        return cell
    }
}

extension BasketViewController: UICollectionViewDelegateFlowLayout {
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

extension BasketViewController {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellCustomWidth = (collectionView.bounds.width - 100)
        return CGSize(width: cellCustomWidth, height: cellCustomWidth - 100)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let coctailVC = ChoosedCocktailViewController()
        let model = filteredDrinks[indexPath.row]
        let observe = BehaviorRelay<Drinks>(value: model)
        observe.subscribe(onNext: { drinks in
            coctailVC.cocktail = drinks
            print(coctailVC.cocktail as Any)
        })
        navigationController?.pushViewController(coctailVC, animated: true)
    }
}


extension BasketViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        guard !searchText.isEmpty else { filteredDrinks = drinks; return }
        getDrinksForName(searchText)
    }
}

