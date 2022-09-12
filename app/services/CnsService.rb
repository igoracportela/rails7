class CnsService
  DOC_SIZE = 15
  DOC_VERIFIER = 11
  attr_accessor :document_cns

  def initialize(document_cns)
    self.document_cns = document_cns.to_s.delete('^0-9')
  end

  def is_valid?
    return unless self.document_cns.present?
    return if self.document_cns.size != DOC_SIZE

    counter = 0

    self.document_cns.to_s.split('').map { |index| index.to_i }.each_with_index do |item, index|
      counter += (item * (DOC_SIZE - index))
    end

    (counter % DOC_VERIFIER).to_i.equal?(0)
  end
end