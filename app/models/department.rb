class Department < ApplicationRecord
  has_many :employees

  validates_presence_of :name
  validates_presence_of :floor
  validates_associated :employees

  def employee_names
    employees.pluck(:name).join(', ')
  end
end