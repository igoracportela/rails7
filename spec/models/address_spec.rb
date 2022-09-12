require 'rails_helper'

#
# Note: Clean test perspective
#

RSpec.describe Address, type: :model do
  ownereable = Municipe.create(birthdate: Date.today, status: 'active')

  valid_data = {
    ownereable: ownereable,
    street_name: 'Rua paraná',
    number: 'S/N',
    neighborhood: 'Centro',
    city: 'Cascavel',
    state: 'pr',
    zip_code: '85806000',
    complement: 'Esquina',
  }

  subject { described_class.new(valid_data) }

  it "is valid with current attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with invalid number" do
    subject.number = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with invalid number" do
    subject.number = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with invalid city" do
    subject.city = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with invalid state" do
    subject.state = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with valid enum state" do
    expect(Address.states(&:first)).to include(subject.state)
  end

  it "is not valid with invalid neighborhood" do
    subject.neighborhood = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with invalid zip_code" do
    subject.zip_code = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:ownereable) }
  end

  describe "Validations" do
    it { should validate_presence_of(:street_name) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:neighborhood) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
  end

end
