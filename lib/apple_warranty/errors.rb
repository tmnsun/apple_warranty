module AppleWarranty
  module Errors
    # Throw this exception if user try get data befor fetch it
    class DataNotFetchedError < StandardError
    end
  end
end
