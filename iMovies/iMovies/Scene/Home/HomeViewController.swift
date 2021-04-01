//
//  ViewController.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import UIKit

protocol HomeViewControllerDelegate: class {
    func openDetail(withId: Int)
    func openGenre(_ genre: Genre)
}

class HomeViewController: UIViewController {
    
    // MARK: - Vars
    let homeVM: HomeViewModel
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: HomeViewControllerDelegate?
    
    lazy var filmCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.register(FilmCollectionViewCell.self)
        collection.register(GenreCollectionViewCell.self)
        collection.register(HeaderView.self, forSupplementaryViewOfKind: HeaderView.kind, withReuseIdentifier: HeaderView.reuseIdentifier)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        return collection
    }()
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"

        filmCollection.pin(to: view)
        homeVM.fetchData()
        homeVM.reloadData = {
            self.filmCollection.reloadData()
        }
    }
    // MARK: - Actions
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .genres:
                return CollectionLayout.genreItemLayout
            default:
                return CollectionLayout.filmHomeLayout
            }
        }
        
        return layout
    }
    
}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = Section.allCases[section]
        switch section {
        case .nowPlaying:
            return homeVM.nowPlaying.count
        case .popular:
            return homeVM.popular.count
        case .topRated:
            return homeVM.top.count
        case .upcoming:
            return homeVM.upcoming.count
        case .genres:
            return homeVM.genres.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section.allCases[indexPath.section]
        switch section {
        case .nowPlaying:
            let cell: FilmCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let now = homeVM.nowPlaying[indexPath.item]
            cell.configure(withFilmVM: FilmViewModel(film: now))
            return cell
        case .popular:
            let cell: FilmCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let popular = homeVM.popular[indexPath.item]
            cell.configure(withFilmVM: FilmViewModel(film: popular))
            return cell
        case .upcoming:
            let cell: FilmCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let upcoming = homeVM.upcoming[indexPath.item]
            cell.configure(withFilmVM: FilmViewModel(film: upcoming))
            return cell
        case .topRated:
            let cell: FilmCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let top = homeVM.top[indexPath.item]
            cell.configure(withFilmVM: FilmViewModel(film: top))
            return cell
        case .genres:
            let cell: GenreCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let genre = homeVM.genres[indexPath.item]
            cell.configure(withGenreVM: GenreViewModel(genre: genre))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath) as? HeaderView else {
            fatalError("Cannot create header view")
        }
        
        supplementaryView.label.text = Section.allCases[indexPath.section].title
        
        return supplementaryView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = Section.allCases[indexPath.section]
        switch section {
        case .nowPlaying:
           let now = homeVM.nowPlaying[indexPath.item]
            delegate?.openDetail(withId: now.id)
        case .popular:
            let popular = homeVM.popular[indexPath.item]
            delegate?.openDetail(withId: popular.id)
        case .topRated:
            let top = homeVM.top[indexPath.item]
            delegate?.openDetail(withId: top.id)
        case .upcoming:
            let upcoming = homeVM.upcoming[indexPath.item]
            delegate?.openDetail(withId: upcoming.id)
        case .genres:
            let genre = homeVM.genres[indexPath.item]
            delegate?.openGenre(genre)
        }
    }
}
