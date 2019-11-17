import UIKit

class AlbumDetailsViewController: UITableViewController, StoryboardLoadable {
    fileprivate var navigator: SceneNavigator?
    fileprivate var theme: Theme?

    fileprivate var viewModel: AlbumDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerReusableViews()
    }

    func setupDependencies(albumId: String,
                           navigator: SceneNavigator?,
                           networkService: NetworkService,
                           databaseProvider: DatabaseProvider,
                           theme: Theme?) {
        self.navigator = navigator
        self.theme = theme
        self.viewModel = AlbumDetailsViewModel(albumId: albumId,
                                               networkService: networkService,
                                               databaseProvider: databaseProvider)

        viewModel?.onViewModelUpdated = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        styleView()

        showHudOverlay()
        _ = viewModel?.loadData().done { [weak self] in
            self?.removeHudOverlay()
        }
    }
}

extension AlbumDetailsViewController {
    func registerReusableViews() {
        tableView.registerReusableHeaderFooter(AlbumDetailsHeaderView.self)
        tableView.registerReusableHeaderFooter(AlbumDetailsFooterView.self)
        tableView.registerReusableCell(AlbumDetailsTrackCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.trackViewModel.count ?? 0
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(AlbumDetailsHeaderView.self)

        if let headerViewModel = viewModel?.headerViewModel, let theme = theme {
            header.configure(with: headerViewModel)
            header.style(with: theme)
        }

        return header
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(AlbumDetailsFooterView.self)

        if let footerViewModel = viewModel?.footerViewModel, let theme = theme {
            footer.configure(with: footerViewModel)
            footer.style(with: theme)
        }

        footer.onAdd = { [weak self] in
            self?.viewModel?.storeAlbum()
        }

        footer.onRemove = { [weak self] in
            self?.viewModel?.removeAlbum()
        }

        return footer
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(AlbumDetailsTrackCell.self, for: indexPath)

        if let trackViewModel = viewModel?.trackViewModel[indexPath.row], let theme = theme {
            cell.configure(with: trackViewModel)
            cell.style(with: theme)
        }

        return cell
    }
}

extension AlbumDetailsViewController {
    fileprivate func styleView() {
        theme?.apply(style: .lightDarkBackground, to: tableView)
        theme?.apply(style: .lightDark, to: navigationController?.navigationBar)
    }
}
