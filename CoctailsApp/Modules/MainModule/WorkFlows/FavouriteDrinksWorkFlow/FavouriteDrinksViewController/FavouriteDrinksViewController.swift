
//
//  MainPageViewController.swift
//  cocktailsApp
//
//  Created by Eldar on 19/2/23.
//

import UIKit
import SnapKit
import RxRelay

class FavouriteDrinksViewController: UIViewController {

    
    public var goodArray = [Drinks]()
    
        
    //    let notificationCenter = NotificationCenter.default
        
        private var basketArray: [Drinks] = []
        
    //    private var viewModel: MainViewModelType = MainViewModel()
        
        private lazy var viewModel = { FavouriteDrinksViewModel() }()
        
        private func initViewModel() {
    //        isLoading = true
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
    //                self?.isLoading = false
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
        
    //    NotificationCenter.default.post(name: notification, object: nil)
      
        
        // For requesting to API to get next letter's drinks
    //    private var currentLetterUnicodeVoralue: UInt32 = 97
    //    private var currentLetter = "a"
        
        
        
    //    private var drinks: [Drinks] = [] {
    //        didSet {
    //            filteredDrinks = drinks
    //        }
    //    }
        
    //    private var filteredDrinks = [Drinks]() {
    //        didSet {
    //            updateUIwithSearchResultsState(resultIsEmpty: filteredDrinks.isEmpty)
    //            drinksCollectionView.reloadData()
    //        }
    //    }
        
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
        
    //    private lazy var activityIndicator: UIActivityIndicatorView = {
    //        let view = UIActivityIndicatorView()
    //        view.hidesWhenStopped = true
    //        view.startAnimating()
    //        return view
    //    }()
    //
    //    private lazy var isLoading: Bool = false {
    //        didSet {
    //            _ = isLoading ? activityIndicator.startAnimating() :activityIndicator.stopAnimating()
    //        }
    //    }
        
      override func loadView() {
            super.loadView()
            view.backgroundColor = ColorConstants.background
            setupSubViews()
            setUPConstraints()
          
            configureDrinksCollectionView()
          
            configureSearchDrinkSearchBar()
          initViewModel()
    //        getDrinksForLetter(currentLetter)
          
    //      let loginRepsonse = ["userInfo": [basketArray]]
    //
    //      NotificationCenter.default.post(name: NSNotification.Name("NotifyCocktails"), object: nil, userInfo: loginRepsonse)
    //
        }
        
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
            
    //        let dictionary = [basketArray]
    //        notificationCenter.post(name: .changeArrayNotification , object: self, userInfo: dictionary)
    //
         
            
    //    }
        
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //
    //        let dictionary = ["model": basketArray]
    //        notificationCenter.post(name: .changeArrayNotification , object: self, userInfo: dictionary)
    //    }
    //
        private func setupSubViews() {
            view.addSubview(allDrinksTitleLabel)
            view.addSubview(pageInfoSubtitleLabel)
            view.addSubview(searchDrinkSearchBar)
            view.addSubview(backgroundViewForCollection)
            view.addSubview(drinksCollectionView)
            view.addSubview(noCocktailsFoundLabel)
    //        view.addSubview(activityIndicator)
        }
        
        // MARK: Call API methods ()
    //    private func getDrinksForLetter(_ letter: String) {
    //        Task {
    //            isLoading = true
    //            let drinksFromAPI = try await getDrinksForLetter(letter).drinks ?? []
    //            drinks.append(contentsOf: drinksFromAPI)
    //            isLoading = false
    //        }
    //    }
        
    //    private func getDrinksForName(_ name: String) {
    //        Task {
    //            filteredDrinks = try await viewModel.getDrinksByName(name).drinks ?? []
    //        }
    //    }
        
    //    private func updateUIwithSearchResultsState(resultIsEmpty: Bool) {
    //        if filteredDrinks.isEmpty && !drinks.isEmpty {
    //            drinksCollectionView.isHidden = true
    //            noCocktailsFoundLabel.isHidden = false
    //        } else {
    //            drinksCollectionView.isHidden = false
    //            noCocktailsFoundLabel.isHidden = true
    //        }
    //    }
        
        // MARK: Configuring methods ()
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
            
    //        activityIndicator.snp.makeConstraints { make in
    //            make.center.equalToSuperview()
    //            make.height.width.equalTo(24)
    //        }
        }
    }
        

    extension FavouriteDrinksViewController: UICollectionViewDataSource {
        func collectionView(
            _ collectionView: UICollectionView,
            numberOfItemsInSection section: Int
        ) -> Int { viewModel.goodArray.count }
        
        func collectionView(
            _ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
            guard let cell = drinksCollectionView.dequeueReusableCell(
                withReuseIdentifier: MenuCollectionViewCell.identifier,
                for: indexPath
            ) as? MenuCollectionViewCell else { fatalError("xib does not exists") }
            let cellVM = viewModel.getCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
           
            return cell
        }
    }

    extension FavouriteDrinksViewController: UICollectionViewDelegateFlowLayout {
        
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
            let vc = ChoosedCocktailViewController()
    //            ) as? ChoosedCocktailViewController else { fatalError("there is no xib") }
            vc.viewModel.drink = viewModel.filteredDrinks[indexPath.row]
            vc.delegate = self
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
        
    //    private func fetchNextData () {
    //        moveToNextLetter(
    //            letter: &currentLetter,
    //            value: &currentLetterUnicodeVoralue
    //        )
    //        getDrinksForLetter(currentLetter)
    //    }
        
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


    extension FavouriteDrinksViewController: UISearchBarDelegate {
        func searchBar(
            _ searchBar: UISearchBar,
            textDidChange searchText: String
        ) { viewModel.getDrinksWithName(searchText) }
    }

    extension FavouriteDrinksViewController: SelecetProductDelegate {
        func addNewDrink(_ drink: Drinks) {
            basketArray.append(drink)
            print("Added throw delegate and now there are \(basketArray.count) elements in array: \(basketArray)")
        }
        
        func removeLastDrink(_ drink: Drinks) {
            basketArray.removeLast()
            print("Removed throw delegate and now there are \(basketArray.count) elements in array: \(basketArray)")
        }
    }
























    //
    //    let notificationCenter = NotificationCenter.default
    //
    ////    private var viewModel: MainViewModelType = MainViewModel()
    //
    //    var favouriteArray: [Drinks]? {
    //        didSet {
    //
    //        }
    //    }
    //
    ////    private var basketArray: [Drinks] = [] {
    ////        didSet {
    ////            notifyArray = basketArray
    ////        }
    ////    }
    ////
    ////    private var notifyArray = [Drinks]() {
    ////        didSet {
    ////
    ////        }
    ////    }
    //
    ////    var favouriteViewModel: FavouriteViewModel!
    //
    //    // For requesting to API to get next letter's drinks
    ////    private var currentLetterUnicodeVoralue: UInt32 = 97
    ////    private var currentLetter = "a"
    //
    //    //    var cocktail: Drinks?
    //
    ////    private var notificationArray: [Drinks] = []
    ////
    ////    private var drinks = [Drinks]() {
    ////        didSet {
    ////            filteredDrinks = drinks
    ////        }
    ////    }
    //
    ////    private var filteredDrinks = [Drinks]() {
    ////        didSet {
    ////            updateUIwithSearchResultsState(resultIsEmpty: filteredDrinks.isEmpty)
    ////            favouriteDrinksCV.reloadData()
    ////        }
    ////    }
    //
    //    // MARK: Subviews creating
    //    private lazy var allDrinksTitleLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "Your Favourite ❤️"
    //        label.font = UIFont(name: "Avenir Next Bold", size: 26)
    //        label.textColor = .white
    //        label.textAlignment = .center
    //        return label
    //    }()
    //
    //    private lazy var pageInfoSubtitleLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "Cehck your choosed drinks\n and we will deliver them."
    //        label.numberOfLines = 0
    //        label.font = UIFont(name: "Avenir-Roman", size: 18)
    //        label.textColor = .white
    //        label.textAlignment = .center
    //        return label
    //    }()
    //
    //    // UISearchBar for searching drink by name.
    //    private lazy var searchDrinkSearchBar: UISearchBar = {
    //        let searchBar = UISearchBar()
    //        searchBar.placeholder = "Search nice drink"
    //        searchBar.searchTextField.font = UIFont(name: "Avenir-Roman", size: 17)
    //        searchBar.searchBarStyle = .minimal
    //        searchBar.barTintColor = ColorConstants.background
    //        searchBar.searchTextField.backgroundColor = .white
    //        searchBar.enablesReturnKeyAutomatically = false
    //
    //        // Shadow configuration
    //        searchBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    //        searchBar.layer.shadowOffset = CGSize(width: 0, height: 4)
    //        searchBar.layer.shadowOpacity = 1
    //        searchBar.layer.shadowRadius = 4
    //        searchBar.layer.masksToBounds = false
    //
    //        return searchBar
    //    }()
    //
    //    // Background view for UICollectionView creating
    //    private lazy var backgroundViewForCollection: UIView = {
    //        let view = UIView()
    //        view.backgroundColor = ColorConstants.cellBack
    //        view.clipsToBounds = true
    //        view.layer.cornerRadius = 30
    //        return view
    //    }()
    //
    //    private lazy var favouriteDrinksCV: UICollectionView = {
    //        let layout = UICollectionViewFlowLayout()
    //        layout.itemSize = CGSize(width: screenWidth, height: 10)
    //        layout.minimumLineSpacing = 6
    //        layout.scrollDirection = .vertical
    //
    //        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    //        let view = UICollectionView(
    //            frame: .zero,
    //            collectionViewLayout: layout
    //        )
    //
    //        view.registerReusable(CellType: FavouriteCVCell.self)
    //        view.backgroundColor = .clear
    //        view.showsVerticalScrollIndicator = false
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    //
    //    private lazy var noCocktailsFoundLabel: UILabel = {
    //        let label =  UILabel(
    //            frame: CGRect(
    //                x: 0,
    //                y: 0,
    //                width: favouriteDrinksCV.bounds.size.width,
    //                height: 50
    //            )
    //        )
    //        label.text = "Oops, there is No cocktail with this name😊\n Maybe you didn't buy it yet?"
    //        label.font = UIFont(name: "Avenir Next", size: 18)
    //        label.textColor = .black
    //        label.textAlignment = .center
    //        label.numberOfLines = 0
    //        label.isHidden = true
    //        return label
    //    }()
    //
    //    //    private lazy var drinksCollectionView: UICollectionView = {
    //    //        let layout = UICollectionViewFlowLayout()
    //    //        layout.itemSize = CGSize(width: screenWidth, height: 10)
    //    //        layout.minimumLineSpacing = 2
    //    ////        layout.headerReferenceSize = CGSize(width: screenWidth, height: 40)
    //    ////        layout.footerReferenceSize = CGSize(width: screenWidth, height: 20)
    //    //        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    //    //        view.delegate = self
    //    //        view.dataSource = self
    //    //        view.registerReusable(CellType: BasketCollectionViewCell.self)
    //    ////        view.registerReusableView(ViewType: BasketHeaderView.self, type: .UICollectionElementKindSectionHeader)
    //    ////        view.registerReusableView(ViewType: BasketFooterView.self, type: .UICollectionElementKindSectionFooter)
    //    //        view.backgroundColor = ColorConstants.cellBack
    //    //        return view
    //    //    }()
    //
    //
    //
    //    // No Cocktails found Label creating. Appears in case if
    //    // there is no cocktail found with name that was input.
    //
    //    override func loadView() {
    //        super.loadView()
    //
    //        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess(_:)), name: NSNotification.Name ("NotifyCocktails"), object: nil)
    //
    //        view.backgroundColor = ColorConstants.description
    //        setupSubViews()
    //        setUpConstraints()
    //        favouriteDrinksCV.reloadData()
    //        configureDrinksCollectionView()
    ////        print(notificationArray)
    //        //        configureSearchDrinkSearchBar()
    //        //        getDrinksForLetter(currentLetter)
    //        //        NotificationCenter.post(name: .notificationInfo, object: self, userInfo: drinks)
    ////        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "post"), object: nil, userInfo: myDict)
    //    }
    //
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //
    ////        notificationCenter.addObserver(self, selector: #selector(getArray(notification:)), name: .changeArrayNotification, object: nil)
    //    }
    //
    ////    deinit {
    ////        notificationCenter.removeObserver(self)
    ////    }
    ////    override func viewWillAppear(_ animated: Bool) {
    ////        super.viewWillAppear(animated)
    ////        let drinksArray = favouriteViewModel.drinksArray
    ////    }
    //
    //    private func setupSubViews() {
    //        view.addSubview(allDrinksTitleLabel)
    //        view.addSubview(pageInfoSubtitleLabel)
    //        view.addSubview(searchDrinkSearchBar)
    //        view.addSubview(backgroundViewForCollection)
    //        view.addSubview(favouriteDrinksCV)
    //        view.addSubview(noCocktailsFoundLabel)
    //    }
    //
    //    // MARK: Configuring methods ()
    //    private func configureSearchDrinkSearchBar() {
    //        searchDrinkSearchBar.delegate = self
    //    }
    //
    //    private func configureDrinksCollectionView() {
    //        favouriteDrinksCV.register(
    //            MenuCollectionViewCell.self,
    //            forCellWithReuseIdentifier: MenuCollectionViewCell.identifier
    //        )
    //        favouriteDrinksCV.delegate = self
    //        favouriteDrinksCV.dataSource = self
    //    }
    //
    ////    private func updateUIwithSearchResultsState(resultIsEmpty: Bool) {
    ////        if filteredDrinks.isEmpty && !drinks.isEmpty {
    ////            favouriteDrinksCV.isHidden = true
    ////            noCocktailsFoundLabel.isHidden = false
    ////        } else {
    ////            favouriteDrinksCV.isHidden = false
    ////            noCocktailsFoundLabel.isHidden = true
    ////        }
    ////    }
    //
    //    @objc func getArray(notification: Notification) {
    //        let dictionary = notification.userInfo as! [Drinks]
    //        notificationArray = dictionary
    //        print(notificationArray)
    ////        favouriteDrinksCV.reloadData()
    //    }
    //
    //    @objc func loginSuccess(_ notification: Notification) {
    //        print("Notification is working")
    //        print(notification.userInfo?["userInfo"] as? [String: Any] ?? [:])
    //    }
    //    //    @objc func didGetnotification(_ notification: Notification) {
    //    //        favouriteDrinks.
    //    //    }
    //
    //    // MARK: Call API methods ()
    ////    private func getDrinksForLetter(_ letter: String) {
    ////        Task {
    ////            let drinksFromAPI = try await viewModel.getDrinksForLetter(letter).drinks ?? []
    ////            drinks.append(contentsOf: drinksFromAPI)
    ////        }
    ////    }
    //
    ////    private func getDrinksForName(_ name: String) {
    ////        Task {
    ////            filteredDrinks = try await viewModel.getDrinksByName(name).drinks ?? []
    ////        }
    ////    }
    //
    //    // MARK: updateUI() method
    //    private func setUpConstraints() {
    //
    //        allDrinksTitleLabel.snp.makeConstraints { make in
    //            make.top.equalToSuperview().offset(55)
    //            make.centerX.equalToSuperview()
    //        }
    //
    //        pageInfoSubtitleLabel.snp.makeConstraints { make in
    //            make.top.equalTo(allDrinksTitleLabel.snp.bottom).offset(0)
    //            make.centerX.equalToSuperview()
    //            //            make.width.equalTo(232)
    //            make.height.equalTo(77)
    //        }
    //
    //        searchDrinkSearchBar.snp.makeConstraints { make in
    //            make.top.equalTo(pageInfoSubtitleLabel.snp.bottom).offset(0)
    //            make.centerX.equalToSuperview()
    //            make.width.equalTo(250)
    //            make.height.equalTo(50)
    //        }
    //
    //        backgroundViewForCollection.snp.makeConstraints { make in
    //            make.top.equalTo(searchDrinkSearchBar.snp.bottom).offset(10)
    //            make.bottom.equalToSuperview().inset(35)
    //            make.left.right.bottom.equalToSuperview()
    //        }
    //
    //        favouriteDrinksCV.snp.makeConstraints { make in
    //            make.top.equalTo(backgroundViewForCollection.snp.top)
    //            make.left.equalTo(backgroundViewForCollection.snp.left).offset(20)
    //            make.right.equalTo(backgroundViewForCollection.snp.right).offset(-20)
    //            make.bottom.equalTo(backgroundViewForCollection.snp.bottom)
    //        }
    //
    //        noCocktailsFoundLabel.snp.makeConstraints { make in
    //            make.centerX.equalTo(favouriteDrinksCV.snp.centerX)
    //            make.centerY.equalTo(favouriteDrinksCV.snp.centerY)
    //        }
    //    }
    //}
    //
    //extension FavouriteDrinksViewController: UICollectionViewDataSource {
    //    func collectionView(
    //        _ collectionView: UICollectionView,
    //        numberOfItemsInSection section: Int
    //    ) -> Int {  favouriteArray?.count ?? 0 }
    //
    //
    //    func collectionView(
    //        _ collectionView: UICollectionView,
    //        cellForItemAt indexPath: IndexPath
    //    ) -> UICollectionViewCell {
    //        guard let cell = favouriteDrinksCV.dequeueReusableCell(
    //            withReuseIdentifier: FavouriteCVCell.reuseID,
    //            for: indexPath
    //        ) as? FavouriteCVCell else { return UICollectionViewCell() }
    //        cell.coctail = favouriteArray![indexPath.row]
    //        cell.delete(self)
    ////        cell.configure(with: notificationArray[indexPath.row])
    //        //        cell.dispaleo(with: notificationArray[indexPath.row])
    //        return cell
    //    }
    //}
    //
    //extension FavouriteDrinksViewController: UICollectionViewDelegateFlowLayout {
    //    private func moveToNextLetter(
    //        letter: inout String,
    //        value: inout UInt32
    //    ) {
    //        value += 1
    //        let scalar = UnicodeScalar(value)!
    //        letter = String(scalar)
    //    }
    //
    ////    private func fetchNextData () {
    ////        moveToNextLetter(
    ////            letter: &currentLetter,
    ////            value: &currentLetterUnicodeVoralue
    ////        )
    ////        getDrinksForLetter(currentLetter)
    ////    }
    ////
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        // Check if the user has scrolled to the bottom of the view and it is not
    //        // searching cocktail process
    //        let scrollViewContentHeight = favouriteDrinksCV.contentSize.height
    //        let scrollOffsetThreshold = scrollViewContentHeight - favouriteDrinksCV.bounds.size.height
    //
    //        if scrollView.contentOffset.y > scrollOffsetThreshold,
    //           searchDrinkSearchBar.text!.isEmpty {
    ////            fetchNextData()
    //        }
    //    }
    //}
    //
    //extension FavouriteDrinksViewController {
    //    func collectionView(
    //        _ collectionView: UICollectionView,
    //        layout collectionViewLayout: UICollectionViewLayout,
    //        sizeForItemAt indexPath: IndexPath
    //    ) -> CGSize {
    //        let cellCustomWidth = (collectionView.bounds.width - 100)
    //        return CGSize(width: cellCustomWidth, height: cellCustomWidth - 100)
    //    }
    //
    //    func collectionView(
    //        _ collectionView: UICollectionView,
    //        didSelectItemAt indexPath: IndexPath
    //    ) {
    //        let coctailVC = ChoosedCocktailViewController()
    //        let model = filteredDrinks[indexPath.row]
    //        let observe = BehaviorRelay<Drinks>(value: model)
    //        observe.subscribe(onNext: { drinks in
    //            coctailVC.modelOfAlldrinks = drinks
    //            print(coctailVC.modelOfAlldrinks as Any)
    //        })
    //        navigationController?.pushViewController(coctailVC, animated: true)
    //    }
    //}
    //
    //
    //extension FavouriteDrinksViewController: UISearchBarDelegate {
    //    func searchBar(
    //        _ searchBar: UISearchBar,
    //        textDidChange searchText: String
    //    ) { viewModel.getDrinksWithName(searchText) }
    //}
    //
    ////extension FavouriteDrinksViewController {
    ////    func addObserver() {
    ////        NotificationCenter.default.addObserver(forName: notification, object: nil, queue: .main) { [weak self] notification in
    ////            self?.notifyArray
    ////        }
    ////    }
    ////}
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //

