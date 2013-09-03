class Student < User
  importable do |arry|
    raise Importer::InvalidFormatException if arry.size != 4
    attr = {}
    attr[:username], attr[:name], attr[:email], password = arry
    student = Student.new(attr)
    student.password = password
    student.password_confirmation = password
    student.save
  end
end
