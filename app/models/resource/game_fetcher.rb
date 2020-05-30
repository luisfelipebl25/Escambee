module Resource
  class GameFetcher
    def initialize(fetch_method)
      @fetch_method = fetch_method
      @cache = {}
    end

    def fetch(id)
      return @cache[id] unless @cache[id].nil?

      @cache[id] = fetch_method.call(id)
    end

    private

    attr_reader :fetch_method
  end
end
