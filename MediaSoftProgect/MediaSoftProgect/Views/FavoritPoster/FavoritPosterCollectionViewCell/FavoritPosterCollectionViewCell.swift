//
//  FavoritPosterCollectionViewCell.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 03.07.2022.
//

import UIKit
import RealmSwift

protocol FavoritPosterCollectionViewCellProtocol {
    static var identifairCell: String {get set}
    var aletrDelegate: AlertShowCollectionViewCellProtocol? {get set}
    func configure(with app: RealmGfycatModel, cellIndex: Int)
}

class FavoritPosterCollectionViewCell: UICollectionViewCell, FavoritPosterCollectionViewCellProtocol {
    
    var aletrDelegate: AlertShowCollectionViewCellProtocol?
    
    static var identifairCell: String = "FavoritePhotosCollectionViewCell"
    
    var model: RealmGfycatModel?
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let deletFavoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(deletFavoriteButtonAction), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCell()
        cofigurationConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCell() {
        contentView.addSubviews([photoImageView, deletFavoriteButton])
    }
    
    private func cofigurationConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.edges.equalTo(self.contentView)
        }
        
        deletFavoriteButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(with app: RealmGfycatModel, cellIndex: Int) {
        let urlImage = URL(string: app.posterUrl)
        
        photoImageView.sd_setImage(with: urlImage, completed: nil)
        
        deletFavoriteButton.tag = cellIndex
        
        model = app
    }
    
    @objc private func deletFavoriteButtonAction() {
        self.aletrDelegate?.alefrtShow(id: model!._id)
    }
}
