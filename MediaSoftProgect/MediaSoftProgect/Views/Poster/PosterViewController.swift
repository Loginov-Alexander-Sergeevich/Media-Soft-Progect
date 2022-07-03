//
//  PosterViewController.swift
//  MediaSoftProgect
//
//  Created by Александр Александров on 01.07.2022.
//

import UIKit

protocol AlertShowProtocol {
    func alertShow(model: RealmGfycatModel)
}

class PosterViewController: UIViewController {
    
    var viewModel: PosterViewModelProtocol!
    var delegate: AlertShowProtocol?
    
    var posterDataSource: UITableViewDiffableDataSource<Section, Gfycats>!
    
    lazy var posterTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.CellId)
        tableView.delegate = self
        return tableView
    }()
    
    lazy var searchContriller: UISearchController = {
        let search = UISearchController()
        search.searchBar.sizeToFit()
        search.searchBar.placeholder = "Поиск фото"
        search.hidesNavigationBarDuringPresentation = false
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.delegate = self
        return search
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .systemRed
        activityIndicator.style = UIActivityIndicatorView.Style.large
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        viewModel = PosterViewModel()
        

        setView()
        cofigurationConstraints()
        
        viewModel.requestPoster {
            self.creatDataSource()
            self.reloadData()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = viewModel.title
        navigationItem.searchController = searchContriller
        
  
    }
    
    func setView() {
        view.addSubviews([posterTableView])
    }
    
    func cofigurationConstraints() {
        posterTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureCell<T: PosterTableViewCellProtocol>(_ CellId: T.Type, with resultsRequest: Gfycats, for indexPath: IndexPath) -> T {
        
        guard var cell = posterTableView.dequeueReusableCell(withIdentifier: CellId.CellId, for: indexPath) as? T else {fatalError()}
        
        cell.configCell(model: resultsRequest, cellIndex: indexPath.row)
        
        cell.alettDelegate = self
        
        return cell
    }
    
    func creatDataSource() {
        posterDataSource = UITableViewDiffableDataSource(tableView: posterTableView){ tableView, indexPath, item in
            let sectio = Section(rawValue: indexPath.section)
            
            switch sectio {
            default:
                return self.configureCell(PosterTableViewCell.self, with: item, for: indexPath)
            }
        }
        
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Gfycats>()
        
        Section.allCases.forEach { section in
            snapshot.appendSections([section])
            snapshot.appendItems(viewModel.resultRequestGfycat, toSection: section)
        }
        
        posterDataSource.apply(snapshot)
    }
}


extension PosterViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.activityIndicator.startAnimating()
        viewModel.timer?.invalidate()
        viewModel.timer = Timer.scheduledTimer(withTimeInterval: 0.9, repeats: false, block: {[weak self] _ in
            self?.viewModel.searchPoster(name: searchText) {
                self?.creatDataSource()
                self?.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        })
    }
}

extension PosterViewController: AlertShowProtocol {
    func alertShow(model: RealmGfycatModel) {
        let alert = UIAlertController(title: """
                                     Добавить в "Любимые фото"
                                     """,
                                      message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        let add = UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            
            self?.viewModel?.saveDataInRealmBD(model: model)
            
        }
        
        alert.addAction(cancel)
        alert.addAction(add)
        
        alert.modalPresentationStyle = .automatic
        
        present(alert, animated: true, completion: nil)
    }
}

extension PosterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
