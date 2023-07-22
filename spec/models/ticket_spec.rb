require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'Associations' do
    it { should have_many :employee_tickets }
    it { should have_many :employees }
  end

  describe 'Validations' do
    it { should validate_presence_of  :subject }
    it { should validate_presence_of  :age }
  end

  describe 'Instance Methods' do

  end
end