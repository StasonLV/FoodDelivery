//
//  ViewController.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import UIKit

protocol DisplayingLogic: AnyObject {
    func reloadData()
    func scrollTo(row: Int, section: Int)
    func didScroll(state: ScrollState)
}

final class MenuTabController: UIViewController {
    
    private let presenter: MenuTabPresenter
    private lazy var menuTabView = MenuTabView(sections: presenter.sections)
    private let cityBarView = CityBarItem()

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(controller: self)
        configAppearance()
    }
    
    override func loadView() {
        view = menuTabView
    }

    init(presenter: MenuTabPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
}

// MARK: - DisplayingLogic
extension MenuTabController: DisplayingLogic {
    
    func scrollTo(row: Int, section: Int) {
        menuTabView.scrollTo(row: row, section: section)
    }
    
    func reloadData() {
        menuTabView.reloadData()
    }
    
    func didScroll(state: ScrollState) {
        menuTabView.didScroll(state: state)
    }
}

// MARK: - TableView Delegate & DataSource
extension MenuTabController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        presenter.didScroll(scrollView.contentOffset.y)
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        TableHeaderView()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableCell.id,
                                                       for: indexPath) as? MenuTableCell
        else { return UITableViewCell() }
        
        let food = presenter.getFoodByIndex(indexPath.row)
        
        presenter.loadImageData(food.image) { data in
            cell.setImageData(data)
        }
        
        cell.setData(food)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CollectionView Delegate & DataSource
extension MenuTabController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        presenter.sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        switch presenter.sections[indexPath.section] {
            
        case .ads: break
        case .cathegory(let array):
            collectionView.scrollToItem(at: indexPath,
                                        at: .centeredHorizontally,
                                        animated: true)
            presenter.didSelectCathegory(array[indexPath.item].rawValue)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch presenter.sections[indexPath.section] {
        case .ads:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuBannerCollectionCell.id, for: indexPath) as? MenuBannerCollectionCell
            else { return UICollectionViewCell() }
            
            return cell
        case .cathegory(let array):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CathegoryChipsCell.id, for: indexPath) as? CathegoryChipsCell
            else { return UICollectionViewCell() }
            
            let category = array[indexPath.row].rawValue
            cell.config(category)
            
            return cell
        }
    }
}

// MARK: - Config Appearance
private extension MenuTabController {
    
    func configAppearance() {
        menuTabView.tableViewDelegate = self
        menuTabView.tableViewDataSource = self
        
        menuTabView.collectionViewDelegate = self
        menuTabView.collectionViewDataSource = self
        
        let item = UIBarButtonItem(customView: cityBarView)
        navigationItem.leftBarButtonItem = item
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                               for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
