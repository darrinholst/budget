class ApplicationSerializer < ActiveModel::Serializer
  def attributes
    hash = super.tap do |h|
      if options[:export]
        h.delete :id
      end
    end
  end
end
