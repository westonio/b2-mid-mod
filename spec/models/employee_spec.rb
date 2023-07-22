require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "Associations" do
    it { should belong_to :department }
    it { should have_many :employee_tickets }
    it { should have_many :tickets }
  end

  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :level }
  end
end