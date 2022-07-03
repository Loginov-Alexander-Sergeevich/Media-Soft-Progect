//
//  FavoritePosterViewController.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 01.07.2022.
//

import UIKit
import RealmSwift

protocol AlertShowCollectionViewCellProtocol {
    func alefrtShow(id: ObjectId)
}

class FavoritePosterViewController: UIViewController {

    var viewModel: FavoritPosterViewModelProtocol!
    var favoritePosterDataSource: UICollectionViewDiffableDataSource<Section, RealmGfycatModel>?
    
    private lazy var favoritePhotosCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        collectionView.register(FavoritPosterCollectionViewCell.self, forCellWithReuseIdentifier: FavoritPosterCollectionViewCell.identifairCell)
        return  collectionView
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
        viewModel = FavoritPosterViewModel()
        setView()
        cofigurationConstraints()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurationNavigationController()
        
        self.createDataSource()
        self.reloadData()
    }
    
    private func configurationNavigationController() {
        navigationItem.title = viewModel.title
    }
    
    private func setView() {
        view.addSubviews([favoritePhotosCollectionView, activityIndicator])
    }
    
    private func cofigurationConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func configure<T: FavoritPosterCollectionViewCellProtocol>(_ cellId: T.Type, with photoInfoDB: RealmGfycatModel, for indexPath: IndexPath) -> T {
        guard var cell = favoritePhotosCollectionView.dequeueReusableCell(withReuseIdentifier: cellId.identifairCell, for: indexPath) as? T else {
            fatalError("\(cellId)")
        }
        cell.configure(with: photoInfoDB, cellIndex: indexPath.item)
        cell.aletrDelegate = self
        return cell
    }
    
    private func createDataSource() {
        favoritePosterDataSource = UICollectionViewDiffableDataSource<Section, RealmGfycatModel>(collectionView: favoritePhotosCollectionView){ collectionView, indexPath, itemIdentifier in
            let section = Section(rawValue: indexPath.section)
            
            switch section {
            default:
                return self.configure(FavoritPosterCollectionViewCell.self, with: itemIdentifier, for: indexPath)
            }
        }
    }
    
    private func reloadData() {
        
        self.activityIndicator.startAnimating()
        viewModel.timer?.invalidate()
        viewModel.timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
            
            var snapshot = NSDiffableDataSourceSnapshot<Section, RealmGfycatModel>()
            let items = RealmManadger.shared.itemsGfycat()
            Section.allCases.forEach { section in
                
                snapshot.appendSections([section])
                snapshot.appendItems(Array(items), toSection: section)
            }
            self?.favoritePosterDataSource?.apply(snapshot)
            self?.activityIndicator.stopAnimating()
        })
        

    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = Section(rawValue: sectionIndex)!

            switch section {
            case .poster:
                return self.createfavoritePhotosSection(using: section)
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 5
        layout.configuration = config
        return layout
    }
    
    private func createfavoritePhotosSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 0)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)

        return layoutSection
    }
    
}

extension FavoritePosterViewController: AlertShowCollectionViewCellProtocol {

    func alefrtShow(id: ObjectId) {
        let aletr = UIAlertController(title: "Удалить фото?",
                                      message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        let delet = UIAlertAction(title: "Удалить", style: .default) { [weak self] _ in

            self?.viewModel?.deletDataPhoto(id: id)
            
            self?.createDataSource()
            self?.reloadData()
        }
        
        aletr.addAction(cancel)
        aletr.addAction(delet)
        
        self.present(aletr, animated: true, completion: nil)
    }
}
