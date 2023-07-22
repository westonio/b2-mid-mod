class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  validates_presence_of :name
  validates_presence_of :level

  def tickets_by_oldest
    tickets.order(age: :desc)
  end

  def oldest_ticket
    tickets_by_oldest.first
  end
end