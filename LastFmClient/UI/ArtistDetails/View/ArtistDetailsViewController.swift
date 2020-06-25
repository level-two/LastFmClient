// -----------------------------------------------------------------------------
//    Copyright (C) 2020 Yauheni Lychkouski.
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
// -----------------------------------------------------------------------------

import UIKit
import RxSwift
import RxRelay

final class ArtistDetailsViewController: UIViewController, StoryboardLoadable {
    @IBOutlet private var collectionView: UICollectionView?

    private typealias DataSource = UICollectionViewDiffableDataSource<ArtistDetailsViewSection, UUID>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<ArtistDetailsViewSection, UUID>

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupDependencies(viewModel: ArtistDetailsViewModel, navigator: SceneNavigator?, theme: Theme) {
        self.viewModel = viewModel
        self.navigator = navigator
        self.theme = theme
    }

    private let disposeBag = DisposeBag()
    private var dataSource: DataSource?
    private var navigator: SceneNavigator?
    private var theme: Theme?
    private var viewModel: ArtistDetailsViewModel?
}

private extension ArtistDetailsViewController {
    func setupView() {
        registerReusableCells()
        styleView()
        setupLayout()
        setupDataSource()
        setupBindings()
    }

    func registerReusableCells() {
        collectionView?.registerReusableCell(ArtistDetailsCellView.self)
        collectionView?.registerReusableCell(AlbumCardViewCell.self)
    }

    func styleView() {
        theme?.apply(style: .background, to: collectionView)
        theme?.apply(style: .normal, to: navigationController?.navigationBar)
        theme?.apply(style: .background, to: self.view)
    }

    func setupLayout() {
        collectionView?.collectionViewLayout = createLayout()
    }

    func setupDataSource() {
        guard let collectionView = collectionView else { return }

        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, _ in
            guard let section = ArtistDetailsViewSection(rawValue: indexPath.section) else {
                fatalError("Undefined section")
            }

            guard let artistDetails = self?.viewModel?.artistDetails,
                let albums = self?.viewModel?.albums
                else { return nil }

            switch section {
            case .artistDetails:
                let cell = collectionView.dequeueReusableCell(ArtistDetailsCellView.self, for: indexPath)
                cell.configure(with: artistDetails)
                cell.style(with: self?.theme)
                return cell
            case .albums:
                let cell = collectionView.dequeueReusableCell(AlbumCardViewCell.self, for: indexPath)
                cell.set(viewModel: albums[indexPath.item])
                cell.style(with: self?.theme)
                return cell
            }
        }

        viewModel?.contentIsReady
            .filter { $0 }
            .bind { [weak self] _ in
                var snapshot = Snapshot()

                snapshot.appendSections([.artistDetails])
                snapshot.appendItems([UUID()], toSection: .artistDetails)

                snapshot.appendSections([.albums])
                if let albums = self?.viewModel?.albums {
                    snapshot.appendItems(albums.map { _ in UUID() }, toSection: .albums)
                }

                dataSource.apply(snapshot, animatingDifferences: true)
            }.disposed(by: disposeBag)
    }

    func setupBindings() {
        guard let viewModel = viewModel else { return }

        viewModel.showNetworkError.bind { [weak self] interactor in
            self?.showNetworkErrorOverlay(interactor: interactor, theme: self?.theme)
        }.disposed(by: disposeBag)

        viewModel.showHud.bind { [weak self] show in
            self?.view.showHud(show, theme: self?.theme)
        }.disposed(by: disposeBag)

        viewModel.showFullBio
            .bind { [weak self] bio in self?.navigator?.navigate(to: .artistDescription(description: bio)) }
            .disposed(by: disposeBag)

        viewModel.showAlbumDetails
            .bind { [weak self] mbid in self?.navigator?.navigate(to: .albumDetails(mbid: mbid)) }
            .disposed(by: disposeBag)

        collectionView?.rx
            .itemSelected
            .filter { $0.section == ArtistDetailsViewSection.artistDetails.rawValue }
            .map { _ in }
            .bind(to: viewModel.doShowFullBio)
            .disposed(by: disposeBag)

        collectionView?.rx
            .itemSelected
            .filter { $0.section == ArtistDetailsViewSection.albums.rawValue }
            .map { $0.item }
            .bind(to: viewModel.doShowAlbumDetails)
            .disposed(by: disposeBag)
    }
}

private extension ArtistDetailsViewController {
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { section, environment in
            guard let section = ArtistDetailsViewSection(rawValue: section) else {
                fatalError("Undefined section")
            }

            switch section {
            case .artistDetails:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(1))

                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

                let artistSection = NSCollectionLayoutSection(group: group)
                //artistSection.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)

                return artistSection

            case .albums:
                let containerSize = environment.container.effectiveContentSize

                let columns = containerSize.width > 1000 ? 4 :
                              containerSize.width > 600 ? 2 : 1

                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(1))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
                group.interItemSpacing = .fixed(20)

                let albumsSection = NSCollectionLayoutSection(group: group)
                albumsSection.interGroupSpacing = 20
                albumsSection.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)

                return albumsSection
            }
        }
    }
}
