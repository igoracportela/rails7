require 'rails_helper'

#
# Note: Functional, but verbose test perspective
#

RSpec.describe Municipe, type: :model do
  valid_data = {
    full_name: 'I am a robot',
    email: 'imarobot@email.com',
    birthdate: '1986-09-28',
    document_cpf: '05650547084',
    document_cns: '910212926360005',
    ddi: '+55',
    ddd: '11',
    phone: '99999999',
    status: 'active',
  }

  subject { Municipe.create(valid_data) }

  it "is not valid with invalid full_name" do
    invalid_data = valid_data
    invalid_data.except!('full_name')
    invalid_data['full_name'] = nil

    municipe = Municipe.create(invalid_data)
    expect(municipe.valid?).to be false
  end

  it "is not valid with invalid document cpf" do
    invalid_data = valid_data
    invalid_data.except!('document_cpf')
    invalid_data['document_cpf'] = '00000000000'

    municipe = Municipe.create(invalid_data)
    expect(municipe.valid?).to be false
  end

  it "is not valid with invalid document cns" do
    invalid_data = valid_data
    invalid_data.except!('document_cns')
    invalid_data['document_cns'] = '000000000000000'

    municipe = Municipe.create(invalid_data)
    expect(municipe.valid?).to be false
    expect(municipe.document_cns.size).to be(15)
    expect(CnsService.new(municipe.document_cns).is_valid?).to be true
  end

  it "is not valid with invalid phone" do
    invalid_data = valid_data
    invalid_data.except!('phone')
    invalid_data['phone'] = nil

    municipe = Municipe.create(invalid_data)
    expect(municipe.valid?).to be false
  end

  it "is not valid with invalid picture" do
    invalid_data = valid_data
    invalid_data.except!('picture')
    invalid_data['picture'] = nil

    municipe = Municipe.create(invalid_data)
    expect(municipe.valid?).to be false
  end

  it "is not valid with invalid status" do
    invalid_data = valid_data
    invalid_data.except!('status')
    invalid_data['status'] = nil

    municipe = Municipe.create(invalid_data)
    expect(municipe.valid?).to be false
    expect(Municipe.statuses(&:first)).not_to include(municipe.status)
  end

  it "is valid with scoped status" do
    municipe_1 = Municipe.create(birthdate: Date.today, status: 'active')
    municipe_2 = Municipe.create(birthdate: Date.today, status: 'active')
    municipe_3 = Municipe.create(birthdate: Date.today, status: 'inactive')

    expect([municipe_1, municipe_2]).to include(municipe_1, municipe_2)
    expect([municipe_1, municipe_2]).not_to include(municipe_3)
  end

  it "is valid with current attributes" do
    expect(subject.present?).to be true
  end
end
