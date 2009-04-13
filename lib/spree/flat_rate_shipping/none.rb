module Spree
  module FlatRateShipping
    class None
      def calculate_shipping(shipment)
        return 0
      end
    end
  end
end