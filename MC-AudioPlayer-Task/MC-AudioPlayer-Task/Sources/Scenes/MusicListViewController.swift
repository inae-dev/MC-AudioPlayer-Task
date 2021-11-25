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
    var delegate: MusicDelegate?
    
    var currIdx: Int? {
        didSet {
            if let currIdx = currIdx {
                BottomPlayBar.didChangeMusic(to: playList[currIdx])
            }
        }
    }

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
        
        let query = QueriesQuery()
        
        Apollo.shared.client.fetch(query: query) { result in
            switch result {
                case .success(let response):
                    if let users = response.data?.users.compactMap({ $0 }) {
                        print(users)
                    }
                
                case.failure(let error):
                    print(error)
            }
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
            BottomPlayBar.presentedView?.delegate = self
            
            tableView.contentInset.bottom =  BottomPlayBar.presentedView?.bounds.height ?? 100
        }
        
        currIdx = indexPath.row
    }
}

extension MusicListViewController: MusicDelegate {
    func nextMusic(dir: Int) {
        guard let idx = currIdx else { return }
        
        let next = idx + dir
        if (0...playList.count - 1).contains(next) {
            currIdx = next
        } else {
            currIdx = next < 0 ? playList.count - 1 : 0
        }
    }
}
 
