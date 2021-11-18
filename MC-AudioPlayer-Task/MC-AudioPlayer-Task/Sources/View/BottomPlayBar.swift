//
//  BottomPlayBar.swift
//  MC-AudioPlayer-Task
//
//  Created by inae Lee on 2021/11/18.
//

import UIKit

class BottomPlayBar: UIView {
    static let shared = BottomPlayBar()
    
    // MARK: - UIComponenets
    
    let borderView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    let thumbnail = UIImageView().then {
        $0.backgroundColor = .systemGray
        $0.image = UIImage(systemName: "music.note")
    }
    
    let musicTitleLabel = UILabel().then {
        $0.text = "현재 재생되는 곡은 여기에.. 띄워가지고 이렇게 .. 헿"
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
        $0.font = .systemFont(ofSize: 16)
    }
    
    let musicDescLabel = UILabel().then {
        $0.text = "작성자의 이름은 이모씨.."
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .systemGray
    }
    
    lazy var pauseButton = UIButton().then {
        $0.backgroundColor = .systemGray
    }
    
    lazy var nextButton = UIButton().then {
        $0.backgroundColor = .systemGray
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    private init() {
        super.init(frame: .zero)
        
        setView()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setView() {
        backgroundColor = .systemGray6
    }
    
    func setConstraints() {
        [borderView, thumbnail, musicTitleLabel, musicDescLabel, pauseButton, nextButton].forEach { addSubview($0) }
        
        snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.height / 10.0)
        }
        
        borderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        thumbnail.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(thumbnail.snp.height)
        }
        
        musicTitleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnail).offset(10)
            $0.leading.equalTo(thumbnail.snp.trailing).offset(10)
            $0.trailing.equalTo(pauseButton.snp.leading).offset(-10)
        }
        
        musicDescLabel.snp.makeConstraints {
            $0.top.equalTo(musicTitleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(musicTitleLabel)
        }
        
        pauseButton.snp.makeConstraints {
            $0.top.bottom.equalTo(nextButton)
            $0.trailing.equalTo(nextButton.snp.leading).offset(-10)
            $0.width.height.equalTo(thumbnail)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.bottom.equalTo(thumbnail)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.height.equalTo(thumbnail)
        }
    }
}
