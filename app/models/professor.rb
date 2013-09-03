class Professor < User
  importable do |arry|
    raise Importer::InvalidFormatException if arry.size != 4
    attr = {}
    attr[:username], attr[:name], attr[:email], password = arry
    professor = Professor.new(attr)
    professor.password = password
    professor.password_confirmation = password
    professor.save
  end
end
