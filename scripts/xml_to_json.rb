require 'json'

books = {}

abbreviations = {
  "Ge" => "Gen",
  "Ex" => "Exod",
  "Le" => "Lev",
  "Nu" => "Num",
  "Dt" => "Deut",
  "Jos" => "Josh",
  "Jud" => "Jude",
  "Ru" => "Ruth",
  "1Sa" => "1Sam",
  "2Sa" => "2Sam",
  "1Ki" => "1Kgs",
  "2Ki" => "2Kgs",
  "1Ch" => "1Chr",
  "2Ch" => "2Chr",
  "Ezr" => "Ezra",
  "Ne" => "Neh",
  "Es" => "Esth",
  "Job" => "Job",
  "Ps" => "Ps",
  "Pr" => "Prov",
  "Ec" => "Eccl",
  "So" => "Song",
  "Is" => "Isa",
  "Je" => "Jer",
  "La" => "Lam",
  "Eze" => "Ezek",
  "Da" => "Dan",
  "Ho" => "Hos",
  "Joe" => "Joel",
  "Am" => "Amos",
  "Ob" => "Obad",
  "Jon" => "Jonah",
  "Mic" => "Mic",
  "Na" => "Nah",
  "Hab" => "Hab",
  "Zep" => "Zeph",
  "Hag" => "Hag",
  "Zec" => "Zech",
  "Mal" => "Mal",
  "Mt" => "Matt",
  "Mk" => "Mark",
  "Lk" => "Luke",
  "Jn" => "John",
  "Ac" => "Acts",
  "Ro" => "Rom",
  "1Co" => "1Cor",
  "2Co" => "2Cor",
  "Ga" => "Gal",
  "Eph" => "Eph",
  "Php" => "Phil",
  "Col" => "Col",
  "1Th" => "1Thess",
  "2Th" => "2Thess",
  "1Ti" => "1Tim",
  "2Ti" => "2Tim",
  "Tit" => "Titus",
  "Phm" => "Phlm",
  "Heb" => "Heb",
  "Jas" => "Jas",
  "1Pe" => "1Pet",
  "2Pe" => "2Pet",
  "1Jn" => "1John",
  "2Jn" => "2John",
  "3Jn" => "3John",
  "Re" => "Rev"
}

Dir.glob("../txt/*.txt").each do |file|
  book = ""
  passage = ""

  File.open(file).each_with_index do |line, index|
    if line[0] == " "
      books[book]["passages"][passage] = books[book]["passages"][passage] + line
      next
    end
    line = line.split
    next if line.length < 4

    if(['Phm','Jud'].include?(line[0]))
      book = line.slice!(0)
      passage = line.slice!(0)
    elsif line[1].include?('Jn')
      book = line.slice!(0..1).join ''
      passage = line.slice!(0)
    elsif line[1].include?(':')
      book = line.slice!(0)
      passage = line.slice!(0)
    elsif line[2].include?(':')
      book = line.slice!(0..1).join ''
      passage = line.slice!(0)
    else
      next
    end

    # if passage == 'The'
    #   next
    # end

    if book == 'Titus'
      book = 'Tit'
    end

    verse = line.join(" ")
    if(!passage.include?(':'))
      passage = '1:' + passage
    end

    osisAbbreviation = abbreviations[book]

    if(!books[book])
      books[book] = {
        "abbreviation" => osisAbbreviation,
        "passages" => {}
      }
    end

    if(!books[book]["passages"])
      books[book]["passages"] = {}
    end

    books[book]["passages"][passage] = verse
  end
end

books.each do |book, content|
  osisAbbreviation = abbreviations[book]
  File.open("../json/#{osisAbbreviation}.json","w") do |fileToWrite|
    fileToWrite.write(JSON.pretty_generate(content))
  end
end