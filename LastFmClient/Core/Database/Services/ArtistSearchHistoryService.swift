protocol ArtistSearchHistoryService {
    func addToSearchHistory(_ artistMatch: ArtistSearchMatch)
    func removeFromSearchHistory(_ mbid: String)
    func searchHistory() -> [ArtistSearchMatch]
}
