//
//  KeywordsTableViewController.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 17/03/21.
//

import UIKit

class KeywordsTableViewController: UITableViewController {

    let keywordsVM: KeywordsViewModel
    
    init(keywordsVM: KeywordsViewModel) {
        self.keywordsVM = keywordsVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = keywordsVM.keyword.name
        tableView.register(FilmListTableViewCell.self)
        keywordsVM.getMoviesByKeywords()
        keywordsVM.reloadData = {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordsVM.movies.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FilmListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let movie = keywordsVM.movies[indexPath.row]
        cell.configure(withFilm: FilmViewModel(film: movie))
        return cell
    }
}
