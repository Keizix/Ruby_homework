require 'date'

class Student
  attr_reader :surname, :name, :date_of_birth


  @@students = []

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = date_of_birth


    raise ArgumentError, "Date of birth must be in the past" if date_of_birth > Date.today


    add_student
  end


  def calculate_age
    today = Date.today
    age = today.year - date_of_birth.year
    age -= 1 if today < date_of_birth.next_year(age)
    age
  end


  def add_student
    unless @@students.any? { |student| student.surname == @surname && student.name == @name && student.date_of_birth == @date_of_birth }
      @@students << self
    end
  end


  def self.remove_student(student)
    @@students.delete_if { |s| s.surname == student.surname && s.name == student.name && s.date_of_birth == student.date_of_birth }
  end


  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end


  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end


  def self.all_students
    @@students
  end


  def to_s
    "#{surname}, #{name}, Age: #{calculate_age}"
  end
end


students_data = [
  { surname: "Bond", name: "James", date_of_birth: Date.new(2002, 5, 12) },
  { surname: "Wick", name: "John", date_of_birth: Date.new(1983, 10, 27) },
  { surname: "Natus", name: "Vincer", date_of_birth: Date.new(1978, 3, 9) },
  { surname: "Morgan", name: "Samara", date_of_birth: Date.new(1997, 7, 20) }
]


students_data.each do |data|
  Student.new(data[:surname], data[:name], data[:date_of_birth])
end

puts "\nList of unique students:"
Student.all_students.each { |student| puts student }
