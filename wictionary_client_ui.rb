require './ui_helper'

def welcome
  puts "\nWelcome to Wictionary - an online community dictionary.\n\n"
  menu
end

def menu
  choice = nil
  until choice == 'x'
    puts "What would you like to do? Choose from the following options."
    puts "\n'c' to create a new word/definition contribution,"
    puts "'u' to update a contribution, 'd' to delete a contribution"
    puts "'l' to list words, 'f' to list words with definitions, 'x' to exit.\n\n"

    case choice = gets.chomp
    # when 's'
    #   search
    when 'c'
      create
    when 'u'
      update
    when 'd'
      delete 
    when 'l'
      list
    when 'f'
      list_with_definitions    
    end
  end
end

def list
  puts "Here are all the words in the Wictionary:\n\n"
  wordlist = Contribution.list
  wordlist.each {|word| puts "  #{word.id}  #{word.entry}"}
  puts "\n"

end

def list_with_definitions
  puts "Here are all your words and definitions from the Wictionary:\n\n"
  wordlist = Contribution.list
  wordlist.each {|word| puts "  #{word.id}  #{word.entry}#{' '*(20-word.entry.length)}#{word.definition}"}
  puts "\n"
end

def create
  puts "Type the word you would like to contribute to the Wictionary."
  entry = gets.chomp
  puts "Type your definition for the word entered above."
  definition = gets.chomp
  contribution = Contribution.new(:entry => entry, :definition => definition)
  begin
    response = contribution.create
    puts "\n\t#{entry.capitalize} has been added to the Wictionary!\n\n"
  rescue Exception => msg
    puts "ERROR: #{msg}"
  end
end

def update
  list_with_definitions
  puts "Type the number next to the word you would like to update."
  id = gets.chomp
  update_hash = {:id => id}
  puts "Type your update to the word, or enter to skip."
  entry = gets.chomp
  update_hash.merge!(:entry => entry) unless entry.empty?
  puts "Type a new definition for this word, or enter to skip."
  definition = gets.chomp
  update_hash.merge!(:definition => definition) unless definition.empty?
  begin
    response = Contribution.update(update_hash)
    puts "\n\t#{entry.capitalize} has been updated!\n\n"
  rescue Exception => msg
    puts "ERROR: #{msg}"
  end
end

def delete
  list
  puts "Type the number next to the word you would like to delete."
  id = gets.chomp.to_i
  begin
    response = Contribution.delete(id)
    puts "\n\tYour word has been deleted from the Wictionary!\n\n"
  rescue Exception => msg
    puts "ERROR: #{msg}"
  end
end

welcome