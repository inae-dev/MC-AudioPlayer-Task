//
//  MusicTableViewCell.swift
//  MC-AudioPlayer-Task
//
//  Created by inae Lee on 2021/11/17.
//

import UIKit
import Kingfisher

class MusicTableViewCell: UITableViewCell {
    // MARK: - UIComponents

    let thumbnail = UIImageView().then {
        $0.backgroundColor = .systemGray
    }

    let musicTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.lineBreakMode = .byTruncatingTail
    }

    let musicDescLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .thin)
        $0.textColor = .lightGray
    }

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func updateConstraints() {
        super.updateConstraints()
    }
    
    override func prepareForReuse() {
        musicTitleLabel.text = ""
        musicDescLabel.text = ""
        
        thumbnail.image = UIImage()
    }
    
    // MARK: - Method

    func setConstraints() {
        [thumbnail, musicTitleLabel, musicDescLabel].forEach { contentView.addSubview($0) }
        
        thumbnail.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(20).priority(999)
            $0.width.height.equalTo(100)
        }

        musicTitleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnail.snp.top).offset(20)
            $0.leading.equalTo(thumbnail.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }

        musicDescLabel.snp.makeConstraints {
            $0.top.equalTo(musicTitleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(musicTitleLabel)
        }
    }
    
    func setCell(music: Music) {
        musicTitleLabel.text = music.title
        musicDescLabel.text = music.musicDescription
        
        if let url = music.imageURL {
            thumbnail.kf.setImage(with: URL(string: UserDefaults.staticURL + url)!,
                                  placeholder: UIImage(systemName: "music.note"),
                                  options: [.transition(.fade(1)), .cacheOriginalImage])
        }
    }
}
