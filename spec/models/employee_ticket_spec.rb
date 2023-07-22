require 'rails_helper'

RSpec.describe EmployeeTicket, type: :model do
  describe 'Associations' do
    it { should belong_to :employee }
    it { should belong_to :ticket }
  end


  describe 'Instance Methods' do

  end
end