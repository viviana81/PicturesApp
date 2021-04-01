//
//  ListViewController.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 23/02/21.
//

import UIKit

class ListViewController: UITableViewController {

    let listVM: ListViewModel
    var onFilmSelected: ((FilmViewModel) -> Void)?
    
    init(listVM: ListViewModel) {
        self.listVM = listVM
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(FilmListTableViewCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVM.filmViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FilmListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let film = listVM.filmViewModels[indexPath.row]
        cell.configure(withFilm: film)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let film = listVM.filmViewModels[indexPath.row]
        onFilmSelected?(film)
    }
}
