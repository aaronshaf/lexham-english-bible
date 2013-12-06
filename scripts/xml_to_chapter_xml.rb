require 'nokogiri'

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
  "Jdg" => "Judg",
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
  "Titus" => "Tit",
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

xml = File.open('../xml/index.xml')

doc = Nokogiri::XML(xml)

doc.xpath("//leb//book").each do |book|
  abbreviation = book.attribute('id').to_s.gsub(' ','')
  osisAbbreviation = abbreviations[abbreviation]
  
  if(!File.directory?("../xml/" + osisAbbreviation))
    Dir::mkdir("../xml/" + osisAbbreviation)
  end

  chapterNumber = 1
  book.xpath("chapter").each do |chapter|
    paddedChapterNumber = chapterNumber.to_s.rjust(3, "0")

    File.open("../xml/#{osisAbbreviation}/#{paddedChapterNumber}.xml","w") do |fileToWrite|
      fileToWrite.write(chapter)
    end

    chapterNumber += 1
  end
end
