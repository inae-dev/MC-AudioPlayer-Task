//
//  BottomPlayBar.swift
//  MC-AudioPlayer-Task
//
//  Created by inae Lee on 2021/11/18.
//

import UIKit

class BottomPlayBar: UIView {
    static let tagIdx: Int = 5555
    static var presentedView: Self? {
        UIApplication.keyWindow?.viewWithTag(Self.tagIdx) as? Self
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
    
    // MARK: - Detail Components
    
    let detailTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 25, weight: .heavy)
        $0.text = "재생 중인 오디오 제목 - 가운데 넘어가면 다음 줄로"
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.alpha = 0
    }
    
    let detailAuthorLabel = UILabel().then {
        $0.text = "작성자의 이름 어쩌구"
        $0.textAlignment = .center
        $0.textColor = .lightGray
        $0.alpha = 0
    }
    
    // MARK: - Properties
    
    lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleBottomPlayView(_:)))
    lazy var maxHeight = keyWindow.safeAreaLayoutGuide.layoutFrame.height
    lazy var minHeight = UIScreen.main.bounds.height / 10.0
    let maxWidth = UIScreen.main.bounds.width - 20.0
    var keyWindow = UIApplication.keyWindow ?? UIWindow()

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
        /// 다음 음악 재생
    }
    
    @objc
    func handleBottomPlayView(_ gesture: UIPanGestureRecognizer) {
        let translationY = gesture.translation(in: self).y
        let screenHeight = bounds.height
        let velocity = gesture.velocity(in: self)
        
        switch gesture.state {
        case .changed:
            if screenHeight - translationY > minHeight, screenHeight - translationY <= maxHeight {
                snp.updateConstraints { make in
                    make.height.equalTo(screenHeight - translationY)
                }
                
                let percent = (screenHeight - translationY) / maxHeight
                print(Float(percent), maxWidth * percent)
                
                thumbnail.snp.updateConstraints { make in
                    make.width.height.equalTo(maxWidth * percent)
                }
                
                borderView.alpha = 1.0 - CGFloat(percent)
                musicTitleLabel.alpha = 1.0 - CGFloat(percent)
                musicDescLabel.alpha = 1.0 - CGFloat(percent)
                nextButton.alpha = 1.0 - CGFloat(percent)
                pauseButton.alpha = 1.0 - CGFloat(percent)
                detailTitleLabel.alpha = CGFloat(percent)
                detailAuthorLabel.alpha = CGFloat(percent)
                
                panGesture.setTranslation(.zero, in: self)
            }
        case .ended:
            if velocity.y > 0 {
                closeView()
            } else {
                openView()
            }
        default:
            break
        }
    }

    // MARK: - Methods
    
    func setView() {
        tag = Self.tagIdx
        backgroundColor = .systemGray6
        addGestureRecognizer(panGesture)
    }
    
    func setConstraints() {
        [borderView, thumbnail, musicTitleLabel, musicDescLabel, pauseButton, nextButton, detailTitleLabel, detailAuthorLabel].forEach { addSubview($0) }
        
        snp.makeConstraints {
            $0.height.equalTo(minHeight)
        }
        
        borderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        thumbnail.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(minHeight - 20)
        }
        
        musicTitleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnail).offset(10)
            $0.leading.equalTo(thumbnail.snp.trailing).offset(10)
            $0.width.equalTo(190)
        }
        
        musicDescLabel.snp.makeConstraints {
            $0.top.equalTo(musicTitleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(musicTitleLabel)
        }
        
        pauseButton.snp.makeConstraints {
            $0.leading.equalTo(musicTitleLabel.snp.trailing)
            $0.trailing.equalTo(nextButton.snp.leading)
            $0.top.equalTo(nextButton)
            $0.width.height.equalTo(48)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20).priority(999)
            $0.width.height.equalTo(48)
        }
        
        /// detail view
        detailTitleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnail.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        detailAuthorLabel.snp.makeConstraints {
            $0.top.equalTo(detailTitleLabel.snp.bottom).offset(20)
            $0.centerX.equalTo(detailTitleLabel)
        }
        
        layoutIfNeeded()
    }
    
    private func openView() {
        snp.updateConstraints { make in
            make.height.equalTo(maxHeight)
        }
        
        thumbnail.snp.updateConstraints { make in
            make.width.height.equalTo(UIScreen.main.bounds.width - 20.0)
        }
        
        borderView.alpha = 0
        musicTitleLabel.alpha = 0
        musicDescLabel.alpha = 0
        nextButton.alpha = 0
        pauseButton.alpha = 0
        detailTitleLabel.alpha = 1
        detailAuthorLabel.alpha = 1
    }
    
    private func closeView() {
        snp.updateConstraints { make in
            make.height.equalTo(minHeight)
        }
        
        thumbnail.snp.updateConstraints { make in
            make.width.height.equalTo(minHeight - 20)
        }
        
        borderView.alpha = 1
        musicTitleLabel.alpha = 1
        musicDescLabel.alpha = 1
        nextButton.alpha = 1
        pauseButton.alpha = 1
        detailTitleLabel.alpha = 0
        detailAuthorLabel.alpha = 0
    }
    
    // MARK: - Static Method
    
    static func showInKeyWindow() {
        let bottomBar = BottomPlayBar()
        guard let keyWindow = UIApplication.keyWindow else { return }
        
        bottomBar.show(in: keyWindow)
    }
    
    static func didChangeMusic() {
        /// 현재 재생 음악 데이터 변경
        print("change data")
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
