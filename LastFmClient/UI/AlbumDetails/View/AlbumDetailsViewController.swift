import UIKit

class AlbumDetailsViewController: UITableViewController, StoryboardLoadable {
    fileprivate var navigator: SceneNavigator?
    fileprivate var theme: Theme?
//    fileprivate var viewModel: AlbumDetailsViewModel = {
//        var headerViewModel = AlbumDetailsHeaderViewModel(
//        return AlbumDetailsViewModel(headerViewModel: headerViewModel, trackViewModel: trackViewModel)
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerReusableViews()
        styleView()
    }

    func setupDependencies(navigator: SceneNavigator?, theme: Theme?) {
        self.navigator = navigator
        self.theme = theme
    }
}

extension AlbumDetailsViewController {
    func registerReusableViews() {
        tableView.registerReusableHeaderFooter(AlbumDetailsHeaderView.self)
        tableView.registerReusableCell(AlbumDetailsTrackCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.trackViewModel.count
        return 25
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(AlbumDetailsHeaderView.self)
//        header.configure(with: viewModel.headerViewModel)
        if let theme = theme {
            header.style(with: theme)
        }
        return header
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(AlbumDetailsTrackCell.self, for: indexPath)
//        cell.configure(with: viewModel.trackViewModel[indexPath.row])
        if let theme = theme {
            cell.style(with: theme)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Show artist details when name clicked
//        navigator?.navigate(to: .artistDetails)
    }
}

extension AlbumDetailsViewController {
    func styleView() {
        theme?.apply(style: .tableBackground, to: tableView)
    }
}
