//
//  MusicListViewController.swift
//  MC-AudioPlayer-Task
//
//  Created by inae Lee on 2021/11/17.
//

import UIKit

class MusicListViewController: UIViewController {
    // MARK: - UIComponenets

    // MARK: - Properties

    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    // MARK: - Actions

    // MARK: - Methods

    func setView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "재생목록"

        view.backgroundColor = .white
    }
}
