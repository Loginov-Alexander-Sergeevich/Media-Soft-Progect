//
//  PosterTableViewCell.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 01.07.2022.
//

import Foundation
import UIKit
import SDWebImage



protocol PosterTableViewCellProtocol {
    static var CellId: String {get set}
    var model: RealmGfycatModel? {get set}
    var alettDelegate: AlertShowProtocol? {get set}
    func configCell(model: Gfycats, cellIndex: Int)
}

final class PosterTableViewCell: UITableViewCell, PosterTableViewCellProtocol {
    var alettDelegate: AlertShowProtocol?
    
    static var CellId: String = "PosterTableViewCell"
    
    var model: RealmGfycatModel?
    
    let posterImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let titlePosterLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let addFavoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(addFavoriteButtonAction), for: .touchUpInside)
        return button
    }()
    
    let horisontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCell()
        cofigurationConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell() {
        selectionStyle = .none
        contentView.addSubviews([horisontalStackView])
        horisontalStackView.addArrangedSubviews([posterImage, titlePosterLabel, addFavoriteButton])
    }
    
    override func prepareForReuse() {
        posterImage.image = nil
        titlePosterLabel.text = nil
        addFavoriteButton.tintColor = .systemGray
    }
    
    func cofigurationConstraints() {
        let imageSize = CGSize(width: 100, height: 100)
        let buttonSize = CGSize(width: 30, height: 30)
        
        horisontalStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.trailing.leading.equalToSuperview().inset(10)
            //make.leading.equalToSuperview().offset(10)
            
        }
        
        posterImage.snp.makeConstraints { make in
            make.size.equalTo(imageSize)
        }
        
        addFavoriteButton.snp.makeConstraints { make in
            make.size.equalTo(buttonSize)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func configCell(model: Gfycats, cellIndex: Int) {
        let posterUrl = model.mobilePosterUrl
        
        guard let imageUrl = posterUrl else { return }
        
        let url = URL(string: imageUrl)
        
        posterImage.sd_setImage(with: url, completed: nil)
        
        addFavoriteButton.tag = cellIndex
        
        self.titlePosterLabel.text = model.title
        
        
        
        self.model = .init(posterUrl: model.mobilePosterUrl!, title: model.title ?? "")
    }
    
    @objc private func addFavoriteButtonAction(sender: UIButton) {
        guard let model = model else {
            return
        }

        self.alettDelegate?.alertShow(model: model)
    }
}
