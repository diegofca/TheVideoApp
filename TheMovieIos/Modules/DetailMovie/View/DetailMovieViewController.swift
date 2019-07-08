//  ViewController.swift
//  TheMovieIos
//
//  Created by Medios Digitales on 7/7/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.

import UIKit

class DetailMovieViewController: BaseViewController {
    
    @IBOutlet weak var detailTable: UITableView!
    
    lazy var presenter: DetailMoviePresenter = {
        return DetailMoviePresenter()
    }()

    private var headerView : HeaderDetailView!
    private var movieDetails: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationTable()
        initListeners()
        initViews()
    }
    
    func configurationTable(){
        createHeaderView()
        detailTable.register(UINib(nibName: "InfoDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "cellInfo")
        detailTable.register(UINib(nibName: "ButtonsActionViewCell", bundle: nil), forCellReuseIdentifier: "cellButtons")

        detailTable.estimatedRowHeight = UITableView.automaticDimension
        detailTable.tableHeaderView = headerView
        detailTable.tableHeaderView = nil
        detailTable.addSubview(headerView)
        detailTable.contentInset = UIEdgeInsets(top: presenter.heigthPosterInView, left: 0, bottom: 0, right: 0)
        detailTable.contentOffset = CGPoint(x: 0, y: -presenter.heigthPosterInView )
    }
    
    private func createHeaderView() {
        headerView = Bundle.main.loadNibNamed("HeaderDetailView", owner: nil, options: nil)?.first as? HeaderDetailView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: presenter.heigthPosterInView)
    }
    
    func initViews(){
        headerView.closeViewBtn.addAction(for: .touchUpInside) {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func initListeners(){
        
        presenter.listenerMovieDetails = { [weak self] movie in
            guard let strongSelf = self else { return }
            strongSelf.movieDetails = movie
        }
        
        presenter.listenerTitleMovie = { [weak self] title in
            guard let strongSelf = self else { return }
            strongSelf.headerView.titleDetail.text = title
        }
        
        presenter.listenerPosterUrl = { [weak self] urlPoster in
            guard let strongSelf = self else { return }
            strongSelf.headerView.imageDetail.af_setImage(withURL: urlPoster)
        }
        
        presenter.listenerTrailerUrl = { [weak self] urlTrailer in
            guard let strongSelf = self else { return }
            strongSelf.headerView.setTrailerUrl(urlTrailer)
            strongSelf.headerView.playTrailerBtn.addAction(for: .touchUpInside, {
                 strongSelf.headerView.playTrailer()
            })
        }
        
        
    }
    
    func getMovieDetail(_ id: Int?){
        presenter.getMovieDetail(id)
    }
    
}

extension DetailMovieViewController : UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 1
            case 1:
                return 4
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellButtons", for: indexPath) as! ButtonsActionViewCell
                return cell
            
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellInfo", for: indexPath) as! InfoDetailTableViewCell

                switch indexPath.row {
                    case 0:
                        cell.setData("Descripción", movieDetails.overview ?? "")
                    case 1:
                        cell.setData("Votos", String(movieDetails.vote_count ?? 0))
                    case 2:
                        cell.setData("Popularidad", String(movieDetails.popularity ?? 0))
                    default:
                        cell.setData("Calificación", String(movieDetails.vote_average ?? 0))
                    }
                return cell
           
            default:
                return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if headerView != nil {
            let yPos: CGFloat = -scrollView.contentOffset.y
            if yPos > 0 {
                var imgRect: CGRect? = headerView?.frame
                imgRect?.origin.y = scrollView.contentOffset.y
                imgRect?.size.height = presenter.heigthPosterInView + yPos  - presenter.heigthPosterInView
                headerView?.frame = imgRect!
            }
        }
    }
    
    
}
