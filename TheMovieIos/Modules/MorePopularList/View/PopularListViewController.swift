//  PopularListViewController.swift
//  Created by Medios Digitales on 7/6/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.

import UIKit

class PopularListViewController: BaseViewController {
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    var searchController : UISearchController!
    
    lazy var presenter: PopularListPresenter = {
        return PopularListPresenter()
    }()
    
    var popularMovies: [Movie] = [] {
        didSet { moviesCollection.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionConfig()
        initDataListener()
        setNavigationUi()
        presenter.getPopularList()
    }
    
    func collectionConfig(){
        moviesCollection.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        moviesCollection.collectionViewLayout = layout
        
        searchController = creatingSearhBarToTable()
        searchController.searchBar.scopeButtonTitles = ["Spiderman", "Harry Potter", "Cars", "All"]
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }

    private func initDataListener(){
        presenter.listenerMovies = { [weak self] movies in
            guard let strongSelf = self else { return }
            strongSelf.popularMovies = movies
        }
        
        presenter.listenerError = {  [weak self] error in
            guard let strongSelf = self else { return }
            strongSelf.alertError(tittle: "Error en la descarga", body: ":c", nil)
        }
        
    }
}

//// -> Extension: datasource y delegado de collecion
extension PopularListViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = popularMovies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        cell.setImageCell(pathUrl: cellData.poster_path)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = UIScreen.main.bounds.width / 3 - 12
        return CGSize(width: widthCell, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVc = DetailMovieViewController.init(nibName: "DetailMovieViewController", bundle: nil)
        self.present(detailVc, animated: true, completion: nil)
        detailVc.getMovieDetail(popularMovies[indexPath.row].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == popularMovies.count - 1 {
            presenter.getPopularList()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.dismiss(animated: true, completion: nil)
    }
}

extension PopularListViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchBar.endEditing(true)
        searchController.dismiss(animated: true, completion: nil)
//        self.viewModel.filteredMovies.removeAll(keepingCapacity: true)
//        self.viewModel.activeSearch = false
//        self.tableMoviesPopular.reloadData()
    }
    
    //Delegado del boton buscar del Searchbar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        searchController.dismiss(animated: true, completion: nil)
        self.moviesCollection.reloadData()
    }
}

