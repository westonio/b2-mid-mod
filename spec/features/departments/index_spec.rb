require 'rails_helper'

RSpec.describe 'Department #index page', type: :feature do
  describe 'When I visit the Department index page' do
    before :each do
      @cx = Department.create!(name: 'CX', floor: "Third" )
        @michael = @cx.employees.create!(name: 'Michael', level: 2)
        @emily = @cx.employees.create!(name: 'Emily', level: 5)
        @tyler = @cx.employees.create!(name: 'Tyler', level: 4)
      @sales = Department.create!(name: 'Sales', floor: "First" )
        @conner = @sales.employees.create!(name: 'Conner', level: 3)
        @rachel = @sales.employees.create!(name: 'Rachel', level: 4)
      @hr = Department.create!(name: 'HR', floor: "Second" )
        @nina = @hr.employees.create!(name: 'Nina', level: 4)
        @eddie = @hr.employees.create!(name: 'Eddie', level: 6)

      visit "/departments"
    end

    it 'shows each departments name' do
      expect(page).to have_content(@cx.name)
      expect(page).to have_content(@sales.name)
      expect(page).to have_content(@hr.name)
    end

    it 'shows each departments floor' do
      expect(page).to have_content(@cx.floor)
      expect(page).to have_content(@sales.floor)
      expect(page).to have_content(@hr.floor)
    end

    it 'lists the names of all employees for each department' do
      expect(page).to have_content("Michael, Emily, Tyler")
      expect(page).to have_content("Conner, Rachel")
      expect(page).to have_content("Nina, Eddie")
    end
  end
end