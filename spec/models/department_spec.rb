require "rails_helper"

RSpec.describe Department, type: :model do
  describe "Associations" do
    it { should have_many :employees }
  end

  describe "instance methods" do
    before :each do
      @cx = Department.create!(name: 'CX', floor: "Third" )
      
      @michael = @cx.employees.create!(name: 'Michael', level: 2)
      @emily = @cx.employees.create!(name: 'Emily', level: 5)
      @tyler = @cx.employees.create!(name: 'Tyler', level: 4)
    end

    it 'can list employee names' do
      expect(@cx.employee_names).to eq("Michael, Emily, Tyler")
    end
  end
end