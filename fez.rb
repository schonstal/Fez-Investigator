#!/usr/bin/ruby

require 'colorize'

LETTERS = {
  :front => %w{ g t z m t v n r },
  :right => %w{ m n k s n o h l },
  :back => %w{ f b i h a e h s },
  :left => %w{ y t c b g x b a }
}

PAGES = [
  { :back => "P", :front => [
    %w{ f f i l r e w o },
    %w{ t n s r h t n e },
    %w{ t y p s l h e n },
    %w{ o e c n n a a c },
    %w{ h o t t o n i r },
    %w{ d r g t a e e p },
    %w{ i c o }
  ]},
  { :back => "A", :front => [
    %w{ o o p v o a t e },
    %w{ e o a n n e i r },
    %w{ o s t o a a m m },
    %w{ v p i s b s e i },
    %w{ x t f a t o a a },
    %w{ e t g e l n n c },
    %w{ e w s }
  ]},
  { :back => "E", :front => [
    %w{ o h s s r t h v },
    %w{ i d e o g o t v },
    %w{ o i h e e r t i },
    %w{ l r e n t h d n },
    %w{ h e v e e o a o },
    %w{ v n t t f s t o },
    %w{ f e t }
  ]},
  { :back => "A", :front => [
    %w{ t r i t e r n i },
    %w{ d o n b v d d l },
    %w{ r e p s i d y e },
    %w{ a p h e l r r h },
    %w{ d i b f o i t e },
    %w{ d i t r i a e t },
    %w{ p e n }
  ]},
  { :back => "E", :front => [
    %w{ r n m e s f a v },
    %w{ h f p o i h g p },
    %w{ i e e t l s o e },
    %w{ b w t g s y n t },
    %w{ e n y n d t n n },
    %w{ e s a h l a a a },
    %w{ d e e }
  ]},
  { :back => "B", :front => [
    %w{ m w o i v c c r },
    %w{ h l c t d g f e },
    %w{ n w s t t c e p },
    %w{ i e v v v t w o },
    %w{ a h o m h f p c },
    %w{ p a a s o d d e },
    %w{ o h i }
  ]},
  { :back => "V", :front => [
    %w{ v e s i b o i s },
    %w{ d s i f i l a e },
    %w{ v d a s w e r r },
    %w{ d s t s a e i t },
    %w{ e s r o p r t d },
    %w{ n d e a t p h v },
    %w{ s r e }
  ]},
  { :back => "B", :front => [
    %w{ o e b o n s g n },
    %w{ e f f e e e e a },
    %w{ e o e e t g a t },
    %w{ n e i e w e e e },
    %w{ r x i g i g e a },
    %w{ e n o s m c s s },
    %w{ a d d }
  ]},
]

def counts
  puts "             " + ("A".."Z").to_a.join("  ")
  totals = {}
  ("a".."z").each { |letter| totals[letter] = 0 }

  PAGES.each_with_index do |page, index|
    output = "Page #{index+1} (#{page[:back].light_green}): " 
    sums = {}
    ("a".."z").each { |letter| sums[letter] = 0 }
    page[:front].each do |row|
      row.each do |letter|
        sums[letter] += 1 
        totals[letter] += 1
      end
    end
    sums.keys.sort.each do |letter|
      output += "#{sums[letter].to_s.rjust(2)} ".send(letter.capitalize == page[:back] ? :light_green : (index % 2 > 0 ? "light_" : "")+'magenta')
    end
    puts output
  end

  puts "            -----------------------------------------------------------------------------"
  output = "    TOTALS: "
  totals.keys.sort.each do |letter|
    output += "#{totals[letter].to_s.rjust(2)} "
  end
  puts output
  puts
end

def show
  PAGES.each_with_index do |page,index|
    puts "#{index + 1} (#{page[:back]}): "
    8.times do |n|
      letters = ""
      7.times do |m|
        letters += " " + (page[:front][6-m][n].nil? ? " " : page[:front][6-m][n].capitalize)
      end
      puts letters
    end
    puts
  end
end

def riddle
  puts "WHAT IS MY NAME?"
  puts "HINT: MY FIRST HALF IS WHAT IT IS, MY SECOND HALF IS HALF OF WHAT MADE IT."
  puts
  LETTERS.each do |key, value|
    puts "#{key.to_s.ljust(5).capitalize}: #{value.map(&:capitalize).join(' ')}" +
      " (Random: #{value.sort_by { rand }.map(&:capitalize).join(' ')})"
  end
end

#counts
ex = []
ex << :show if ARGV.include? "--pages"
ex << :counts if ARGV.include? "--counts"
ex << :riddle if ARGV.include? "--riddle"
ex.each { |m| send(m) }

if ex == []
  puts "USAGE: fez.rb <--counts> <--pages> <--riddle>"
  puts "counts: Show count of all letters in ancient tome"
  puts "pages: Show all pages in ancient tome translated"
  puts "riddle: Show the name riddle"
end
