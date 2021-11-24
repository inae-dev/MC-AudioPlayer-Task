//
//  BottomPlayBar.swift
//  MC-AudioPlayer-Task
//
//  Created by inae Lee on 2021/11/18.
//

import UIKit

protocol MusicDelegate {
    func nextMusic(dir: Int)
}

class BottomPlayBar: UIView {
    static let tagIdx: Int = 5555
    static var presentedView: Self? {
        let keyWindow = UIApplication.shared.windows.first(where:  { $0.isKeyWindow })
        
        return keyWindow?.viewWithTag(Self.tagIdx) as? Self
    }
    
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
        $0.setImage(UIImage(named: "ico_playAudio_small"), for: .normal)
        $0.setImage(UIImage(named: "ico_pauseAudio_small"), for: .selected)
        $0.addTarget(self, action: #selector(didTapPauseButton(_:)), for: .touchUpInside)
    }
    
    lazy var nextButton = UIButton().then {
        $0.setImage(UIImage(named: "ico_nextAudio_small"), for: .normal)
        $0.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Properties
    
    var delegate: MusicDelegate?
    
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
    
    @objc
    func didTapPauseButton(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @objc
    func didTapNextButton(_ sender: UIButton) {
        delegate?.nextMusic(dir: 1)
    }

    // MARK: - Methods
    
    func setView() {
        tag = Self.tagIdx
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
            $0.trailing.equalTo(nextButton.snp.leading).offset(-10)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(48)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(48)
        }
        
        layoutIfNeeded()
    }
    
    // MARK: - Static Method
    
    static func showInKeyWindow() {
        let bottomBar = BottomPlayBar()
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        
        bottomBar.show(in: keyWindow)
    }
    
    static func didChangeMusic(to music: Music) {
        guard let presentedView = presentedView else { return }
        presentedView.musicTitleLabel.text = music.title
        presentedView.musicDescLabel.text = music.musicDescription
        
        if let url = music.imageURL {
            presentedView.thumbnail.kf.setImage(with: URL(string: UserDefaults.staticURL + url)!,
                                  placeholder: UIImage(systemName: "music.note"),
                                                options: [.transition(.fade(1)), .cacheOriginalImage])
        }
    }
    
    
    // MARK: - Method
    
    private func show(in view: UIView) {
        view.addSubview(self)
                
        snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
    }
    
    private func hide() {
        self.removeFromSuperview()
    }
}
