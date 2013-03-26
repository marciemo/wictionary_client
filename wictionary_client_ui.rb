require './ui_helper'

def welcome
  puts "Welcome to Wictionary - an online community dictionary."
  menu
end

def menu
  choice = nil
  until choice == 'x'
    puts "What would you like to do? Choose from the following options."
    puts "'s' to search for a word, 'c' to create a new word/definition contribution,"
    puts "'u' to update a contribution, 'd' to delete a contribution, 'l' to list,"
    puts "'x' to exit."

    case choice = gets.chomp
    when 's'
      search
    when 'c'
      create
    when 'u'
      update
    when 'd'
      delete 
    when 'l'
      list     
    end
  end
end

def list
  puts "Here are all the words in the Wictionary:\n\n"
  wordlist = Contribution.list
  wordlist.each {|word| puts "  #{word.id}  #{word.entry}"}

end

def list_with_definitions
  puts "Here are all your words and definitions from the Wictionary:\n\n"
  wordlist = Contribution.list
  wordlist.each {|word| puts "  #{word.id}\t#{word.entry}#{' '*(20-word.entry.length)}#{word.definition}"}
end

def create
  puts "Type the word you would like to contribute to the Wictionary."
  entry = gets.chomp
  puts "Type your definition for the word entered above."
  definition = gets.chomp
  contribution = Contribution.new(:entry => entry, :definition => definition)
  begin
    response = contribution.create
    puts response.body
  rescue Exception => msg
    puts msg
  end
end

def search
  puts "Type the word you would like to find."
  entry = gets.chomp
  begin
    response = Contribution.search(:entry => entry)
    puts response.body
  rescue Exception => msg
    puts msg
  end
end

def update
  list_with_definitions
  puts "\nType the number next to the word you would like to update."
  entry = gets.chomp
  puts "Type the addition you would like to contribute for this word."
  definition = gets.chomp
  contribution = Contribution.new(:entry => entry, :definition => definition)
  begin 
    response = contribution.update
    puts response.body
  rescue Exception => msg
    puts msg
  end
end

def delete
  list
  puts "\nType the number next to the word you would like to delete."
  id = gets.chomp.to_i
  begin
    response = Contribution.delete(id)
    puts response.body
  rescue Exception => msg
    puts msg
  end
end

welcome