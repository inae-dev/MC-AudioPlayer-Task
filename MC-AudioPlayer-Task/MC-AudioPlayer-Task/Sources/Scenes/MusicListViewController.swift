//
//  MusicListViewController.swift
//  MC-AudioPlayer-Task
//
//  Created by inae Lee on 2021/11/17.
//

import SnapKit
import Then
import UIKit

class MusicListViewController: UIViewController {
    // MARK: - UIComponenets

    lazy var tableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 140.0
        $0.register(MusicTableViewCell.self, forCellReuseIdentifier: String(describing: MusicTableViewCell.self))
        $0.dataSource = self
        $0.delegate = self
    }

    // MARK: - Properties
    
    var playList: [Music] = []

    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setConstraints()
        fetchData()
    }

    // MARK: - Actions

    // MARK: - Methods

    func setView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "재생목록"

        view.backgroundColor = .white
    }

    func setConstraints() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func fetchData() {
        MusicService.shared.fetchPlayList { [weak self] response in
            self?.playList = response
            
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension MusicListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MusicTableViewCell.self)) as? MusicTableViewCell else { return UITableViewCell() }
        cell.setCell(music: playList[indexPath.row])

        return cell
    }
}

// MARK: - UITableViewDataSource

extension MusicListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if BottomPlayBar.presentedView == nil {
            BottomPlayBar.showInKeyWindow()
            
            tableView.contentInset.bottom =  BottomPlayBar.presentedView?.bounds.height ?? 100
        }
        
        BottomPlayBar.didChangeMusic(to: playList[indexPath.row])
    }
}
